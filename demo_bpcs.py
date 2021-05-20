from bjontegaard_metric import *

print 'Sample 1'
R1 = np.array([6975,4347,2652,1612])
PSNR1 = np.array([32.11,36.53,34.11,31.85])
R2 = np.array([7036,4387,2719,1576])
PSNR2 = np.array([39.12,36.51,34.19,31.78])

print 'BD-PSNR: ', BD_PSNR(R1, PSNR1, R2, PSNR2)
print 'BD-RATE: ', BD_RATE(R1, PSNR1, R2, PSNR2)


print '\nSample 2'
R12 = np.array([57118,41684,29502,20640])
PSNR12 = np.array([40.18,36.18,32.24,31.02])
R22 = np.array([56350,40985,29265,20403])
PSNR22 = np.array([40.09,36.21,32.17,30.24])

print 'BD-PSNR: ', BD_PSNR(R12, PSNR12, R22, PSNR22, 1)
print 'BD-RATE: ', BD_RATE(R12, PSNR12, R22, PSNR22, 1)


# print '\nSample 3'
# print BD_PSNR([686.76, 309.58, 157.11, 85.95],
#               [40.28, 37.18, 34.24, 31.42],
#               [893.34, 407.8, 204.93, 112.75],
#               [40.39, 37.21, 34.17, 31.24])