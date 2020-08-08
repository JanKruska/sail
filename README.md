# sail
Source code for my Bachelor's thesis on the integration of constraints into the Surrogate-Assisted Illumination (SAIL) algorithm,
described in: 

"Data-Efficient Exploration, Optimization, and Modeling of Diverse Designs
 through Surrogate-Assisted Illumination" presented at GECCO 2017. 
https://arxiv.org/abs/1702.03713

and 

"Aerodynamic Design Exploration through Surrogate-Assisted Illumination"
presented at AIAA Aviation and Aeronautics Forum 2017.
https://hal.inria.fr/hal-01518786/file/aiaa_sail.pdf

The original source code can be found in [SAIL](https://github.com/alexander-hagg/sail)

In addition to the three original domains, two new domains, 3D velomobile-wheelcase deformations, aswell as 3D-E-Scooter deformations, were added.


Produced using

    Matlab R2019b


Required MATLAB Toolboxes:

* Parallel Computing (for parallel speed ups)

* Statistics and Machine Learning (for Sobol sequence)


Includes:
    GMPL  Version 4.1, Rasmussen & Nickisch (help gpml)

**Required Software:**

**Git LFS** to resolve stl files as they are too large for normal git. Information on how to setup and resolve files using git lfs can be found [here](https://docs.github.com/en/github/managing-large-files/versioning-large-files)

**[gptoolbox](https://github.com/alecjacobson/gptoolbox/)** for geometry processing, located somewhere in the Matlab path

**Wheelcase domain:**
* OpenFOAM computational fluid dynamics simulator (v1906)(https://www.openfoam.com/)
* gpToolbox; The boolean mesh operations are mex functions and need to be compiled before they can be used, see [gptoolbox](https://github.com/alecjacobson/gptoolbox/blob/master/README.md) for information on how to compile them)

**E-Scooter domain:**
* OpenFOAM computational fluid dynamics simulator (v1906)(https://www.openfoam.com/)        
	
For further information on Airfoil, Velo & Mirror domain see [SAIL](https://github.com/alexander-hagg/sail)
