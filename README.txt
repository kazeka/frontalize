res = matlab.loadmat('/Developer/litl/frontalize/DataAlign2LFWa.mat')
res['REFTFORM'][0, 0][2][0][0][3][0][0][2][0] = u'/usr/share/octave/packages/image-2.2.0/maketform.m'
res['REFTFORM'][0, 0][3][0][0][3][0][0][2][0] = u'/usr/share/octave/packages/image-2.2.0/maketform.m'




Code for frontalizing faces based on the method described in [1].

If you find this code useful and use it in your own work, please add
reference to [1] and, if appropriate, other papers mentioned below.


Install:
----------
  1. Unzip files to a local folder (<frontalization>)
  2. Install dependency libraries (see below).
  3. Edit the script facial_feature_detection.m to reflect the locations and specific instructions used to detect facial features on your system.
  4. That's it -- just run demo.m


Dependencies:
---------------------
  The demo uses the following dependencies. You MUST have these installed and
  available on the MATLAB path:
  1. calib function available from [2,3], required for estimating the query
      camera projection matrix, C_Q. Calib functions are assumed to be
      under folder <frontalization>/calib
  2. Facial feature detection functions. The demo provides examples
      showing frontalization results obtained using the SDM method [4] (default,
	  used in paper), the facial feature detector of Zhu and Ramanan [5], or
	  the dlib detector (Kazemi and Sullivan) [6]. Please see
      the script facial_feature_detection.m on how to use these (as well as
      edit paths to the detector used in practice, in case these differ from
      the ones in the script). See the function makeNew3DModel.m in case
      a different facial feature detector is used.
  3. OpenCV required by calib for calibration routines and some of the
      detectors for cascade classifiers (e.g., SDM)


 References:
-------------------
  [1] Tal Hassner, Shai Harel, Eran Paz, Roee Enbar, "Effective Face
  Frontalization in Unconstrained Images," forthcoming.
  See project page for more details:
  http://www.openu.ac.il/home/hassner/projects/frontalize

  [2] T. Hassner, L. Assif, and L. Wolf, "When Standard RANSAC is Not Enough: Cross-Media
  Visual Matching with Hypothesis Relevancy," Machine Vision and Applications (MVAP),
  Volume 25, Issue 4, Page 971-983, 2014
  Available: http://www.openu.ac.il/home/hassner/projects/poses/

  [3] T. Hassner, "Viewing Real-World Faces in 3D," International Conference on Computer Vision (ICCV),
  Sydney, Austraila, Dec. 2013
  Available: http://www.openu.ac.il/home/hassner/projects/poses/

  [4] X. Xiong and F. De la Torre, "Supervised Descent Method and its Application to Face
  Alignment," IEEE Conference on Computer Vision and Pattern Recognition (CVPR), 2013
  Available: http://www.humansensing.cs.cmu.edu/intraface

  [5] X. Zhu, D. Ramanan. "Face detection, pose estimation and landmark localization in the wild,"
  Computer Vision and Pattern Recognition (CVPR) Providence, Rhode Island, June 2012.
  Available: http://www.ics.uci.edu/~xzhu/face/

  [6] V. Kazemi, J. Sullivan. "One Millisecond Face Alignment with an
  Ensemble of Regression Trees," Computer Vision and Pattern Recognition
  (CVPR), Columbus, Ohio, June, 2014
  Available through the dlib library: http://blog.dlib.net/2014/08/real-time-face-pose-estimation.html




Copyright 2014, Tal Hassner
http://www.openu.ac.il/home/hassner/projects/frontalize

The SOFTWARE ("frontalization" and all included files) is provided "as is", without any
guarantee made as to its suitability or fitness for any particular use.
It may contain bugs, so use of this tool is at your own risk.
We take no responsibility for any damage that may unintentionally be caused
through its use.

ver 1.2, 18-May-2015
