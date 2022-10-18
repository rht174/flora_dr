# Importing Libraries
import tensorflow as tf
from keras.layers import Dense, Flatten
from keras.models import Model
from keras.preprocessing.image import ImageDataGenerator
from glob import glob

dir_name_list = ['apple', 'cherry', 'corn', 'grape', 'pepper_bell', 'potato', 'strawberry', 'tea', 'tomato']
image_size = [224, 224, 3]
model_score = {
    'apple': None, 'cherry': None, 'corn': None, 'grape': None, 'pepper_bell': None, 'potato': None, 'strawberry': None,
    'tea': None, 'tomato': None
}

# add preprocessing layer to the front of ResNet
keras_transfer = tf.keras.applications.MobileNetV2(
    include_top=False,
    weights="imagenet",
    input_shape=image_size,
    classifier_activation="softmax"
)

# don't train existing weights
for layer in keras_transfer.layers:
    layer.trainable = False

# main for loop
for folder in dir_name_list:
    train_path = f'data/{folder}/train'
    valid_path = f'data/{folder}/val'
    folders = glob(f'data/{folder}/train/*')
    print(folders)
    # our layers - you can add more if you want
    x = Flatten()(keras_transfer.output)
    prediction = Dense(len(folders), activation='softmax')(x)
    # create a model object

    model = Model(inputs=keras_transfer.input, outputs=prediction)

    # view the structure of the model
    model.summary()

    # tell the model what cost and optimization method to use
    model.compile(
        loss='categorical_crossentropy',
        optimizer='adam',
        metrics=['accuracy']
    )

    train_datagen = ImageDataGenerator(rescale=1. / 224,
                                       shear_range=0.2,
                                       zoom_range=0.2,
                                       horizontal_flip=True,
                                       vertical_flip=True,
                                       rotation_range=0.2)

    test_datagen = ImageDataGenerator(rescale=1. / 224)

    training_set = train_datagen.flow_from_directory(f'data/{folder}/train',
                                                     target_size=(224, 224),
                                                     batch_size=32,
                                                     class_mode='categorical')

    test_set = test_datagen.flow_from_directory(f'data/{folder}/val',
                                                target_size=(224, 224),
                                                batch_size=32,
                                                class_mode='categorical')

    # callback for early stopping
    callback = tf.keras.callbacks.EarlyStopping(
        monitor="accuracy",
        patience=5,
        verbose=1,
        mode="auto",
    )

    print(f'Training {folder} model !!!')

    # fit the model
    history = model.fit(
        training_set,
        validation_data=test_set,
        epochs=25,
        steps_per_epoch=len(training_set),
        validation_steps=len(test_set),
        callbacks=[callback],
        verbose=1
    )

    # score
    scores = model.evaluate(test_set)
    print(scores)
    model_score[folder] = scores
    model.save(f'trained_model/{folder}.h5')

print(model_score)
