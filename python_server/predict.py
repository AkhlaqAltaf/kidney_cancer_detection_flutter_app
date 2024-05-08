import numpy as np
import tensorflow as tf

interpreter = tf.lite.Interpreter(model_path="model.tflite")
interpreter.allocate_tensors()

# Get input and output details
input_details = interpreter.get_input_details()
output_details = interpreter.get_output_details()

# Load labels
with open("dict.txt", "r") as f:
    labels = f.read().splitlines()

# Load and preprocess the image
image_path = ...  # Provide the path to your image
image = tf.keras.preprocessing.image.load_img(image_path, target_size=(224, 224))
image = tf.keras.preprocessing.image.img_to_array(image)
image = image / 255.0  # Normalize the image

# Add batch dimension
image = np.expand_dims(image, axis=0)

# Set input tensor
input_shape = input_details[0]['shape']
interpreter.set_tensor(input_details[0]['index'], image.astype(np.uint8))

# Run inference
interpreter.invoke()

# Get the output tensor
output_data = interpreter.get_tensor(output_details[0]['index'])

# Post-process the output
predicted_label = labels[np.argmax(output_data)]

print("Predicted label:", predicted_label)
