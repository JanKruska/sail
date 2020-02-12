# sail
Source code for the Surrogate-Assisted Illumination (SAIL) algorithm, as
described in: 

"Data-Efficient Exploration, Optimization, and Modeling of Diverse Designs
 through Surrogate-Assisted Illumination" presented at GECCO 2017. 
https://arxiv.org/abs/1702.03713

and 

"Aerodynamic Design Exploration through Surrogate-Assisted Illumination"
presented at AIAA Aviation and Aeronautics Forum 2017.
https://hal.inria.fr/hal-01518786/file/aiaa_sail.pdf

Forked from [SAIL](https://github.com/alexander-hagg/sail)

In addition to the three original domains, two new domains, 3D velomobile-wheelcase deformations, aswell as 3D-E-Scooter deformations, are included.

To apply SAIL to a new domain only new representation and evaluation functions must be created. More sample domains will be made public as their are published. If you are interested in creating a new domain and having trouble, don't hesistate to ask!


Produced using

    Matlab R2019b


Required MATLAB Toolboxes:

* Parallel Computing (for parallel speed ups)

* Statistics and Machine Learning (for Sobol sequence)


Includes:
    GMPL  Version 4.1, Rasmussen & Nickisch (help gpml)

    gpToolbox (https://github.com/alecjacobson/gptoolbox/)


Required Software:

    Git LFS to resolve stl files as they are too large for normal git.

	For Airfoil, Velo & Mirror domain see [SAIL](https://github.com/alexander-hagg/sail)

    Wheelcase domain
        OpenFOAM computation fluid dynamics simulator (v1906)
        (https://www.openfoam.com/)

        gpToolbox(included in modules, boolean mesh operations are mex functions and need to be compiled before they can be used, see [modules/gptoolbox/mex/README.md](modules/gptoolbox/mex/README.md) for information on how to compile the mex-files
            and [modules/gptoolbox/README.md](modules/gptoolbox/README.md) and/or [gptoolbox](https://github.com/alecjacobson/gptoolbox/blob/master/README.md) for general information)

    E-Scooter domain
        OpenFOAM computation fluid dynamics simulator (v1906)
        
        (https://www.openfoam.com/)        
