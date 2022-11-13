# Importing Libraries
import tensorflow as tf
from tensorflow.keras.models import Sequential
from tensorflow.keras.callbacks import ModelCheckpoint, EarlyStopping
from tensorflow.keras.layers import Dense, Activation, Flatten, Conv2D, MaxPooling2D
from keras.layers import Dense, Flatten
from keras.models import Model
from keras.preprocessing.image import ImageDataGenerator
from glob import glob

# dir_name_list = ['apple', 'corn', 'grape', 'tea', 'tomato']
dir_name_list = ['tea', 'tomato']
image_size = [224, 224, 3]
model_score = {
    'apple': None, 'corn': None, 'grape': None, 'tea': None, 'tomato': None
}

'''
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
'''

# main for loop
for folder in dir_name_list:
    train_path = f'data/{folder}/train'
    valid_path = f'data/{folder}/val'
    folders = glob(f'data/{folder}/train/*')
    print(folders)
    # # our layers - you can add more if you want
    # x = Flatten()(keras_transfer.output)
    # prediction = Dense(len(folders), activation='softmax')(x)
    # # create a model object
    #
    # model = Model(inputs=keras_transfer.input, outputs=prediction)
    #
    # # view the structure of the model
    # model.summary()
    #
    # # tell the model what cost and optimization method to use
    # model.compile(
    #     loss='categorical_crossentropy',
    #     optimizer='adam',
    #     metrics=['accuracy']
    # )

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

    model = Sequential()
    model.add(Conv2D(64, (3, 3), activation='relu', padding='same', input_shape=image_size))
    model.add(MaxPooling2D(2, 2))
    model.add(Conv2D(64, (3, 3), activation='relu', padding='same'))
    model.add(MaxPooling2D(2, 2))
    model.add(Conv2D(64, (3, 3), activation='relu', padding='same'))
    model.add(MaxPooling2D(2, 2))
    model.add(Conv2D(128, (3, 3), activation='relu', padding='same'))
    model.add(MaxPooling2D(2, 2))
    model.add(Flatten())
    model.add(Dense(4, activation='softmax'))

    # Compile the Model
    model.compile(optimizer=tf.keras.optimizers.Adam(learning_rate=0.001),
                  loss='categorical_crossentropy',
                  metrics=['accuracy'])
    model.summary()

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
        epochs=10,
        steps_per_epoch=len(training_set),
        validation_steps=len(test_set),
        callbacks=[callback],
        verbose=1
    )

    # score
    scores = model.evaluate(test_set)
    print(scores)
    model_score[folder] = scores
    model.save(f'trained_model/nov_model/{folder}.h5')

print(model_score)
