# -*- coding: utf-8 -*-
"""
Created on Fri Oct  9 18:04:02 2020

@author: Fifi
"""

# LAB01
# 09/10/2020
# FATEMEH CHANGIZIAN

import numpy as np
import cv2

# EX1. SQUARES

# Defining a 1024*1024 square matrix(image) with graylevel 32:
img1=np.ones((1024, 1024))
img1=np.uint8(img1)
img1= img1 *32

#Choosing a 512*512 square matrix in the center of the previous one
mx = 512
S = 512   # side of square2
#Replacing value=64 instead of 32 to create a new square image matrix with graylevel 64.
img1[(mx-S//2):(mx+S//2), (mx-S//2):(mx+S//2)]=64

#Choosing a 256*256 square matrix in the center of the previous one
S = 256   # side of square3
#Replacing value=128 instead of 64 to create a new square image matrix with graylevel 128.
img1[(mx-S//2):(mx+S//2), (mx-S//2):(mx+S//2)]=128

img = cv2.imread('lena.tif') #load image
#Resize image
img = cv2.resize(img, None , fx=0.5, fy=0.5, interpolation=cv2.INTER_AREA)

#Choosing a 128*128 square matrix in the center of the previous one
S = 128; # side of Lena image
#assignning image value to the 128*128 centered square
img1[(mx-S//2):(mx+S//2), (mx-S//2):(mx+S//2)]=img[:,:,0]


cv2.imshow('Squares', img1)
#save output image
cv2.imwrite('EX1Squares.jpg', img1)



# EX2. MOSAIC

#Load the image
imgoriginal = cv2.imread('Lenna.jpg')

#the Upper right corner of the output image which is blue channel image with a vertical flip
b = imgoriginal.copy()
# set green and red channels to 0
b[:, :, 1] = 0
b[:, :, 2] = 0
flipVertical = cv2.flip(b, 0)

#the Lower left corner of the output image which is red channel with an horizontal flip
r = imgoriginal.copy()
# set blue and green channels to 0
r[:, :, 0] = 0
r[:, :, 1] = 0
flipHorizontal = cv2.flip(r, 1)

#the Lower right corner of the output image which is green channel with both flips.
g = imgoriginal.copy()
# set blue and red channels to 0
g[:, :, 0] = 0
g[:, :, 2] = 0
flipBoth = cv2.flip(g, -1)

# Concatenate (combine) images vertically and horizontally
res1 = cv2.vconcat([imgoriginal, flipHorizontal]) 
res2 = cv2.vconcat([flipVertical, flipBoth]) 
res = cv2.hconcat([res1, res2]) 

cv2.imshow('Ex2. Mosaic', res)

# Save output image
cv2.imwrite('Ex2.Mosiac.jpg', res)

 
cv2.waitKey(0)
cv2.destroyAllWindows()
