import numpy as np
from numpy import linalg as LA
from sklearn.cluster import KMeans
import matplotlib.pyplot as plt
# import math

X = np.array([[3.1, 2.7, 3.3, 2.9, 1.1, 0.7, 1.2],
              [0.8, 1.2, 0.9, 1.1, 1.7, 2.1, 2.2]], dtype=float)
print("-----------------------------------\nMacierz:\n", X)
X_mean = np.mean(X, 1)  # srednia po wierszach
print("-----------------------------------\nSrednia po wierszach:\n", X_mean)
X_repeted = np.repeat(X_mean, [7, 7]).reshape(2, 7)  # zamiennik repmat
print("-----------------------------------\nRepmat sredniej:\n", X_repeted)
X_cntr = X - X_repeted  # centralizacja
print("-----------------------------------\nScentralizowane probki\n", X_cntr)
X_cntr_mean = np.mean(X_cntr, 1)  # srednia scentralizowanych probek
print("-----------------------------------\nSrednia scentralizowanych probek\n", X_cntr_mean)
# @ - mnożenie macierzy; T - transpozycja; mianownik - liczba probek - 1
X_cov = X_cntr @ X_cntr.T / (X_cntr.shape[1] - 1)
print("-----------------------------------\nKowariancja\n", X_cov)
VALUES, VECTORS = LA.eig(X_cov)
print("-----------------------------------\nWektory wlasne\n", VECTORS)
print("-----------------------------------\nWartosci wlasne\n", VALUES)
Z = VECTORS.T @ X_cntr
print("-----------------------------------\nSkladowe glowne\n", Z)

line_4 = np.linspace(-4, 4, num=4)
line_0 = np.linspace(0, 0, num=4)


x_space = np.linspace(-4, 4, 10)
def f(x): return x * VECTORS[1][0] / VECTORS[0][0]


y_space = f(x_space)
Z_y = f(Z[0])

# x_PC1 = Z[0][0]
# y_PC1 = Z_y[0]
# dist_PC1 = math.dist([x_PC1, y_PC1], [0, 0])
# PC1 = {"x": x_PC1, "y": y_PC1, "dist_[x,y]-[0,0]": dist_PC1,
#        "skladowa_x": x_PC1/dist_PC1, "skladowa_y": y_PC1/dist_PC1}
# print("-----------------------------------\nSkladowa PC1\n", PC1)


kmeans = KMeans(2)
kmeans.fit(X.T)
y_kmeans = kmeans.fit_predict(X.T)
print("-----------------------------------\Klastry\n", y_kmeans)
centers = kmeans.cluster_centers_
print("-----------------------------------\Centroidy\n", centers)


plt.plot(line_4, line_0, c='grey')
plt.plot(line_0, line_4, c='grey')
plt.scatter(centers[0, 0], centers[0, 1], c='y', s=1500, alpha=0.5)
plt.scatter(centers[1, 0], centers[1, 1], c='pink', s=1500, alpha=0.5)
plt.plot(x_space, y_space, c='b', linestyle='dashed', linewidth=0.75,
         label='Kierunek zgodny z wektorem cechy')
plt.plot(X[0, :], X[1, :], 'x', c='black', label='Dane oryginalne')
plt.plot(X_cntr[0, :], X_cntr[1, :], 'x',
         c='red', label='Dane scentralizowane')
plt.plot(Z[0, :], Z_y, "*", c='green', label='Skladowe glówne')
plt.plot(centers[:, 0], centers[:, 1], 'D',
         c='purple', label='Centroidy', alpha=0.5)
plt.grid(color='grey', linestyle='-', linewidth=0.2)
plt.legend()
plt.ylim(-4, 4)
plt.xlim(-4, 4)
plt.show()

wcss = []
for i in range(1, 7):
    kmeans2 = KMeans(i)
    kmeans2.fit(X.T)
    wcss_iter = kmeans2.inertia_
    wcss.append(wcss_iter)

number_clusters = range(1, 7)
plt.plot(number_clusters, wcss)
plt.title('Elbow Method')
plt.xlabel('Liczba klastrów')
plt.ylabel('WCSS')  # Within-Cluster Sum of Square
plt.show()
