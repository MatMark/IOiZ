import matplotlib.pyplot as plt
import numpy as np
import scipy.sparse.linalg as sla
from tensorly.decomposition import tucker
from sklearn.datasets import fetch_olivetti_faces

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

core5, factors5 = tucker(data, [5, 5, 5])
# core10, factors10 = tucker(data, [10, 10, 10])
# core20, factors20 = tucker(data, [20, 20, 20])
# core40, factors40 = tucker(data, [40, 40, 40])

print(core5.shape)

print(factors5)

plt.imshow(core5.reshape(image_shape), cmap=plt.cm.gray)
plt.axis("off")
plt.show()


# for i in range(0, J):
#     ax = plt.subplot(int(J/5)+1, 5, i+1)
#     plt.imshow(VECTORS[:, i].reshape(image_shape), cmap=plt.cm.gray)
#     plt.title(int(i))
#     plt.axis("off")
# plt.show()
