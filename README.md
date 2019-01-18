# LSDCF
Learning Low-rank and Sparse Discriminative Correlation Filters for Coarse-to-Fine Visual Object Tracking

## Instruction for LSDCF Tracker:
- We use HOG [1][2], CN [3], and ResNet-50 [4][5] as our features. 
- Code modules refer to ECO [6] in feature extraction.

### Dependencies:
MatConvNet [7], PDollar Toolbox [8], mtimesx and mexResize. 

## Installation and Run:
- Run install.m file to compile the libraries.
- Run demo_LSDCF_single to illustrate selected sequences.
Copy the tracker_LSDCF.m to the vot-workspace. (replace #LOCATION with the path of this folder)

### Operating system:
- Successfully passed Ubuntu 14.04 LTS, Matlab R2018a, CPU Intel(R) Xeon(R) E5-2643 
- and Windows10 MATLAB 2016a, Inteli5 2.50GHz CPU, GTX 960 GPU

### References:
- [1] Henriques, João F., et al. "High-speed tracking with kernelized correlation filters." 
IEEE Transactions on Pattern Analysis and Machine Intelligence 37.3 (2015): 583-596.
- [2] Dalal, Navneet, and Bill Triggs. "Histograms of oriented gradients for human detection." 
Computer Vision and Pattern Recognition, 2005. CVPR 2005. 
- [3] Van De Weijer, Joost, et al. "Learning color names for real-world applications." 
IEEE Transactions on Image Processing 18.7 (2009): 1512-1523.
- [4] He, Kaiming, et al. "Deep residual learning for image recognition." 
Proceedings of the IEEE conference on computer vision and pattern recognition. 2016.
- [5] Bhat, Goutam, Joakim Johnander, Martin Danelljan, Fahad Shahbaz Khan, and 
Michael Felsberg. "Unveiling the Power of Deep Tracking." arXiv preprint arXiv:1804.06833 (2018).
- [6] Danelljan, Martin, et al. "Eco: Efficient convolution operators for tracking." 
Proceedings of the 2017 IEEE Conference on Computer Vision and Pattern Recognition (CVPR), 2017.
- [7] MatConvNet: http://www.vlfeat.org/matconvnet/
- [8] PDollar Toolbox: https://pdollar.github.io/toolbox/
