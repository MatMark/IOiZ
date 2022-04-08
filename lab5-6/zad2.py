from sklearn.datasets import fetch_olivetti_faces
import matplotlib.pyplot as plt
from sklearn import decomposition

# Classes                                40
# Samples total                         400
# Dimensionality                       4096
# Features            real, between 0 and 1
# =================   =====================
#
# The image is quantized to 256 grey levels and stored as unsigned 8-bit
# integers; the loader will convert these to floating point values on the
# interval [0, 1], which are easier to work with for many algorithms.
#
# The "target" for this database is an integer from 0 to 39 indicating the
# identity of the person pictured; however, with only 10 examples per class.
#
# The original dataset consisted of 92 x 112, while the version available here
# consists of 64x64 images.

data, target = fetch_olivetti_faces(return_X_y=True)
n_samples, n_features = data.shape
image_shape = (64, 64)

# wyswietlenie 4 pierwszych osob
for i in range(0, 40):
    ax = plt.subplot(4, 10, i+1)
    plt.imshow(data[i].reshape(image_shape), cmap=plt.cm.gray)
    plt.title(int(i))
    plt.axis("off")
plt.show()

# wyswietlenie pierwszego zdjecia wszystkich osob
l = 0
for i in range(0, 400):
    if i % 10 == 0:
        l = l + 1
        ax = plt.subplot(4, 10, l)
        plt.imshow(data[i].reshape(image_shape), cmap=plt.cm.gray)
        plt.title(int(i))
        plt.axis("off")
plt.show()

est4 = decomposition.PCA(
    n_components=4)
est4.fit(data)
res4 = est4.components_

for j in range(0, 4):
    ax = plt.subplot(1, 4, j+1)
    plt.imshow(res4[j].reshape(image_shape), cmap=plt.cm.gray)
    plt.title(int(j))
    plt.axis("off")
plt.show()


est10 = decomposition.PCA(
    n_components=10)
est10.fit(data)
res10 = est10.components_

for j in range(0, 10):
    ax = plt.subplot(2, 5, j+1)
    plt.imshow(res10[j].reshape(image_shape), cmap=plt.cm.gray)
    plt.title(int(j))
    plt.axis("off")
plt.show()

est20 = decomposition.PCA(
    n_components=20)
est20.fit(data)
res20 = est20.components_

for j in range(0, 20):
    ax = plt.subplot(4, 5, j+1)
    plt.imshow(res20[j].reshape(image_shape), cmap=plt.cm.gray)
    plt.title(int(j))
    plt.axis("off")
plt.show()

est30 = decomposition.PCA(
    n_components=30)
est30.fit(data)
res30 = est30.components_

for j in range(0, 30):
    ax = plt.subplot(6, 5, j+1)
    plt.imshow(res30[j].reshape(image_shape), cmap=plt.cm.gray)
    plt.title(int(j))
    plt.axis("off")
plt.show()
