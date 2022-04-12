from sklearn.datasets import fetch_olivetti_faces
import numpy as np
import scipy.sparse.linalg as sla
import matplotlib.pyplot as plt

# # Classes                                40
# # Samples total                         400
# # Dimensionality                       4096
# # Features            real, between 0 and 1
# # =================   =====================
# #
# # The image is quantized to 256 grey levels and stored as unsigned 8-bit
# # integers; the loader will convert these to floating point values on the
# # interval [0, 1], which are easier to work with for many algorithms.
# #
# # The "target" for this database is an integer from 0 to 39 indicating the
# # identity of the person pictured; however, with only 10 examples per class.
# #
# # The original dataset consisted of 92 x 112, while the version available here
# # consists of 64x64 images.

data, target = fetch_olivetti_faces(return_X_y=True)
n_samples, n_features = data.shape  # 400, 4096
image_shape = (64, 64)

J = 30

centered = np.empty([n_samples, n_features])

for i in range(0, n_samples):
    temp_mean = np.mean(data[i], 0)
    temp = data[i] - temp_mean
    centered[i] = temp
centered = centered.T
cov = centered @ centered.T / (centered.shape[1] - 1)
VALUES, VECTORS = sla.eigsh(cov, J, which='LM')
order = np.argsort(VALUES)
VALUES[::-1].sort()
VECTORS = VECTORS[:, order]

for i in range(0, J):
    ax = plt.subplot(int(J/5)+1, 5, i+1)
    plt.imshow(VECTORS[:, i].reshape(image_shape), cmap=plt.cm.gray)
    plt.title(int(i))
    plt.axis("off")
plt.show()
