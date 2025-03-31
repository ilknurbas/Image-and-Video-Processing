# Image-and-Video-Processing

This repository showcases a series of tasks aimed at exploring and mastering fundamental and advanced techniques in image and video processing using MATLAB. Each exercise focuses on specific concepts, ranging from basic image manipulations to complex filtering and motion estimation methods, providing practical applications and deeper insights into the field.
 
**`Ex1: MATLAB Image Processing Toolbox`**

This task involves manipulating images by converting them to grayscale, altering and recombining RGB components, and structuring visual layouts. Batch processing techniques are applied to automate resizing, mirroring, rotating, and saving image outputs. Additionally, binary image operations are performed to create and analyze matrices, focusing on subset analysis and counting non-zero elements. 

**`Ex2: Quantization and Visual Perception`**

This task involves understanding and applying quantization functions to create uniform quantizers with varying levels (128, 64, 32, etc.), manipulating and enhancing images by reducing contouring effects through noise addition. Additionally, simultaneous contrast is investigated by generating 8-bit images to verify perceptual differences in luminance.

**`Ex3: Pixel Operations and Sampling Technique`**

This task includes constructing histograms manually, performing contrast stretching to enhance image intensities, and analyzing results through visual and statistical comparisons. Down-sampling techniques are applied by reducing image sizes using different pixel selection methods (e.g., (2,2), (1,1), average intensity). Furthermore, the concept of visual adaptation is examined in perceptual scenarios, and the effects of mathematical transformations (addition, scaling, rotation) on image histograms are analyzed.

**`Ex4: Image Enhancement and Histogram Techniques`**

This task focuses on intensity transformations such as logarithmic and power-law adjustments to optimize image visual quality. Custom histogram equalization is implemented to enhance contrast in images, followed by comparisons to the results of ContrastStretch methods. Additionally, histogram matching is explored to align the histogram of an input image with that of a reference image. The properties of histogram equalization, including its limitations and potential improvements for specific images is also analyzed.

**`Ex5: Filtering Techniques and Noise Reduction`**

This task explores advanced image filtering methods and noise reduction techniques . Laplacian filters with varying high-boost parameters are used to enhance edge details in images. Directional filtering is implemented to smooth images in specific orientations and reduce motion blur, while a custom function generates filters for angles like 0°, 45°, 90°, and 135°. Median filtering techniques are applied to reduce localized noise, with an additional thresholded variation to retain specific pixel intensities under controlled conditions. 

**`Ex6: Signal Creation, Fourier Transform, and Frequency Domain Filtering`**

This task focuses on generating 128x128 gray-scale images with varying signal patterns, including constant values, ramps, delta functions, and cosine signals, all within the double precision range. Fourier transform is applied to analyze the frequency components of the created signals, examining energy concentration and interpreting key insights. The task also involves Butterworth filters, applying both low-pass and high-pass filters to process images, showcasing the filters and resulting outputs.

**`Ex7: Noise Generation, Restoration, and Filtering Techniques`**

This task focuses on Gaussian, salt & pepper, and Rayleigh noise that are added to grayscale images to analyze their effects on image quality. Restoration is performed using geometric, arithmetic, and harmonic mean filters, comparing results to determine the most suitable method for each noise type. Additionally, a weighted median filter (WMF) is implemented to clean salt and pepper noise while preserving image details better than traditional median filters.

**`Ex8: Motion Blur and Image Restoration Techniques`**

This task investigates motion blurring filter which is implemented to blur images in the frequency domain, then followed by inverse filtering to restore the blurred image while calculating Mean Squared Error values for quality comparison. Wiener filtering is applied to noise-added blurred images to evaluate its effectiveness against inverse filtering, with varying threshold values for unknown noise and signal properties.

**`Ex9: Histogram Equalization and Object Extraction`**

This task focuses on independent histogram equalization which is applied to RGB components, then followed by a custom function to perform histogram equalization in the HSV color space. The effects of both methods are analyzed on different images. Object extraction techniques are employed to identify and isolate the largest lake in a given image, utilizing color space transformations, thresholding operations, and region labeling.

**`Ex10: Color Manipulation and Noise Filtering Across Colorspaces`**

Functions based on Manhattan and Euclidean distance are implemented to suppress colors differing from a user-selected value, verifying results on sample images. Gaussian noise is introduced to isolated and combined RGB channels, with impacts analyzed in both RGB and HSI color spaces. Arithmetic mean filtering is applied to reduce noise, evaluating its effects on different components and colorspaces.

**`Ex11: YUV to RGB Transformation and Chrominance Subsampling`**

This task emphasizes the YUV to RGB transformation, including reshaping and processing image components, centering values, and applying transformation matrices to generate RGB images. Chrominance subsampling is performed in various formats (4:2:2, 4:1:1, 4:2:0) and applied to both chrominance and luminance components. Reconstructed RGB images are evaluated for perceptible differences, and mean squared error values are calculated to validate observations.

**`Ex12: Motion Estimation and Echocardiography Analysis`** 

This task centers on estimating motion between video frames using the Lucas-Kanade optical flow method and evaluating echocardiography videos for heart health assessment. Inter-frame motion estimation involves analyzing the direction and speed of object motion, optimizing parameters such as NoiseThreshold for better results. Echocardiography videos are processed to identify healthy and unhealthy heart conditions based on the movement of the left ventricle wall, incorporating smoothing techniques like adaptive Wiener filters and anisotropic diffusion filters to enhance motion estimation accuracy.




