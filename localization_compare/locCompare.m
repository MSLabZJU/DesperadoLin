%��ʵ����
realLoc = [
    4.308,6.160;
    4.309,5.727;
    4.335,5.275;
    4.340,4.962;
    4.330,4.721;
    4.355,4.437;
    4.354,4.061;
    4.358,3.768;
    4.369,3.417;
    4.401,3.045;
    4.400,2.728;
    4.425,2.367;
    4.418,2.053;
    4.459,1.745;
    4.464,1.409;
    4.455,1.006;
    3.999,0.852;
    3.480,0.777;
    3.106,0.740;
    2.749,0.735;
    2.301,0.775;
    1.829,0.942;
    1.494,0.912;
    1.082,1.001;
    0.896,1.265;
    0.819,1.406;
    0.820,1.797;
    0.850,2.193;
    0.884,2.313;
    0.882,3.660;
    0.872,4.057;
    0.904,4.462;
    0.863,4.787;
    0.827,5.070;
    0.825,5.334;
    ];
%%
loc = [
    4.250,6.189;
    4.234,5.730;
    4.248,5.311;
    4.266,5.034;
    4.283,4.802;
    4.288,4.528;
    4.264,4.141;
    4.269,3.855;
    4.260,3.501;
    4.312,3.167;
    4.298,2.868;
    4.319,2.496;
    4.328,2.216;
    4.368,1.935;
    4.346,1.592;
    4.359,1.194;
    3.941,0.986;
    3.439,0.847;
    3.092,0.874;
    2.752,0.864;
    2.311,0.909;
    1.842,1.060;
    1.503,1.052;
    1.096,1.121;
    0.903,1.301;
    0.783,1.568;
    0.813,1.807;
    0.847,2.213;
    0.890,2.542;
    0.991,3.792;
    0.973,4.168;
    0.989,4.583;
    0.930,4.869;
    0.858,5.064;
    0.839,5.322;
    ];
%%
anchorLoc = [
    5.703,1.059;
    0.903,1.059;
    0.903,5.859;
    5.703,5.859;
    3.303,3.459;
    ];
%%
figure;
scatter(anchorLoc(:,1),anchorLoc(:,2),120);
hold on;
plot(realLoc(:,1),realLoc(:,2));
hold on;
plot(loc(:,1),loc(:,2),'r');