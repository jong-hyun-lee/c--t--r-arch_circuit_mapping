function initial_placement = init_recorded_all(arch, algorithm)
if algorithm == 2
    if arch =='prop_1'
        %% 경우의 수는 다음과 같음
        % case 1,2 인 경우 : [10	12	8	9	15	14	6	2	4	13	7	1	3	11	5]
        % case 3 인 경우 : [7	3	1	11	2	5	6	15	4	9	10	8	13	12	14]
        case_number = randi(6);
        if case_number ==1 || case_number ==2
            initial_placement = [10	12	8	9	15	14	6	2	4	13	7	1	3	11	5];
        elseif  case_number ==3 || case_number ==4
            initial_placement = [7	3	1	11	2	5	6	15	4	9	10	8	13	12	14];
        elseif case_number ==5
            initial_placement = [7	3	1	11	2	5	6	15	4	9	10	8	13	12	14];
        elseif case_number ==6
            initial_placement = [10	12	8	9	15	14	6	2	4	13	7	1	3	11	5];
        end
    elseif arch == 'c-arch' %% 여기만 작성되면 main_integrated [[15,1,3]]을 돌릴 수 있음
        case_number = randi(6);
        if case_number == 1
            initial_placement = [-1	-1	-1	16	-1	-1	-1
                -1	-1	6	-1	11	-1	-1
                -1	14	-1	2	-1	7	-1
                13	-1	4	-1	3	-1	1
                -1	8	-1	10	-1	9	-1
                -1	-1	12	-1	5	-1	-1
                -1	-1	-1	15	-1	-1	-1
                ];
        elseif case_number ==2
            initial_placement =  [-1	-1	-1	16	-1	-1	-1
                -1	-1	6	-1	11	-1	-1
                -1	14	-1	2	-1	7	-1
                13	-1	4	-1	3	-1	1
                -1	8	-1	10	-1	9	-1
                -1	-1	12	-1	5	-1	-1
                -1	-1	-1	15	-1	-1	-1
                ];
        elseif case_number ==3
            initial_placement = [-1	-1	-1	2	-1	-1	-1
                -1	-1	11	-1	3	-1	-1
                -1	14	-1	10	-1	6	-1
                16	-1	8	-1	15	-1	12
                -1	9	-1	1	-1	4	-1
                -1	-1	13	-1	5	-1	-1
                -1	-1	-1	7	-1	-1	-1
                ];
        elseif case_number ==4
            initial_placement = [-1	-1	-1	2	-1	-1	-1
                -1	-1	11	-1	3	-1	-1
                -1	14	-1	10	-1	6	-1
                16	-1	8	-1	15	-1	12
                -1	9	-1	1	-1	4	-1
                -1	-1	13	-1	5	-1	-1
                -1	-1	-1	7	-1	-1	-1
                ];
        elseif case_number ==5
            initial_placement = [-1	-1	-1	16	-1	-1	-1
                -1	-1	6	-1	11	-1	-1
                -1	14	-1	2	-1	7	-1
                13	-1	4	-1	3	-1	1
                -1	8	-1	10	-1	9	-1
                -1	-1	12	-1	5	-1	-1
                -1	-1	-1	15	-1	-1	-1
                ];
        elseif case_number ==6
            initial_placement = [-1	-1	-1	2	-1	-1	-1
                -1	-1	11	-1	3	-1	-1
                -1	14	-1	10	-1	6	-1
                16	-1	8	-1	15	-1	12
                -1	9	-1	1	-1	4	-1
                -1	-1	13	-1	5	-1	-1
                -1	-1	-1	7	-1	-1	-1
                ];
        end
    elseif arch =='t-arch'
        case_number = randi(6);
        if case_number == 1
            initial_placement = [2	14	6	10
                3	11	15	8
                7	1	4	9
                16	5	13	12];
        elseif case_number ==2
            initial_placement = [2	14	6	10
                3	11	15	8
                7	1	4	9
                16	5	13	12];
        elseif case_number ==3
            initial_placement = [14	10	6	2
                4	15	3	7
                13	8	1	11
                5	12	9	16];
        elseif case_number ==4
            initial_placement = [14	10	6	2
                4	15	3	7
                13	8	1	11
                5	12	9	16];
        elseif case_number ==5
            initial_placement = [2	14	6	10
                3	11	15	8
                7	1	4	9
                16	5	13	12];
        elseif case_number ==6
            initial_placement = [14	10	6	2
                4	15	3	7
                13	8	1	11
                5	12	9	16];
        end
    end
elseif algorithm==5
    if arch =='prop_1'
        %% 경우의 수는 다음과 같음
        % case 1,2 인 경우 : [10	12	8	9	15	14	6	2	4	13	7	1	3	11	5]
        % case 3 인 경우 : [7	3	1	11	2	5	6	15	4	9	10	8	13	12	14]
        case_number = randi(6);
        if case_number ==1
            initial_placement = [1	3	2	4	5	6	9	7	8	10	12	11	13	16	15	14];
        elseif case_number ==2
            initial_placement = [1	3	2	4	5	6	9	7	8	10	12	11	13	16	15	14];
        elseif  case_number ==3
            initial_placement = [1	3	2	6	4	5	7	9	8	10	12	11	13	16	15	14];
        elseif case_number ==4
            initial_placement = [1	3	2	6	4	5	7	9	8	10	12	11	13	16	15	14];
        elseif case_number ==5
            initial_placement = [1	3	2	4	5	6	9	7	8	10	12	11	13	16	15	14];
        elseif case_number ==6
            initial_placement = [1	3	2	6	4	5	7	9	8	10	12	11	13	16	15	14];
        end
    elseif arch == 'c-arch' %% 여기만 작성되면 main_integrated [[15,1,3]]을 돌릴 수 있음
        case_number = randi(6);
        if case_number == 1
            initial_placement = [-1	-1	-1	3	-1	-1	-1
                -1	-1	2	-1	14	-1	-1
                -1	5	-1	1	-1	15	-1
                4	-1	7	-1	11	-1	16
                -1	6	-1	9	-1	13	-1
                -1	-1	8	-1	12	-1	-1
                -1	-1	-1	10	-1	-1	-1
                ];
        elseif case_number ==2
            initial_placement =  [-1	-1	-1	3	-1	-1	-1
                -1	-1	2	-1	14	-1	-1
                -1	5	-1	1	-1	15	-1
                4	-1	7	-1	11	-1	16
                -1	6	-1	9	-1	13	-1
                -1	-1	8	-1	12	-1	-1
                -1	-1	-1	10	-1	-1	-1
                ];
        elseif case_number ==3
            initial_placement = [-1	-1	-1	11	-1	-1	-1
                -1	-1	12	-1	16	-1	-1
                -1	8	-1	13	-1	15	-1
                9	-1	10	-1	2	-1	14
                -1	7	-1	6	-1	1	-1
                -1	-1	5	-1	3	-1	-1
                -1	-1	-1	4	-1	-1	-1
                ];
        elseif case_number ==4
            initial_placement = [-1	-1	-1	11	-1	-1	-1
                -1	-1	12	-1	16	-1	-1
                -1	8	-1	13	-1	15	-1
                9	-1	10	-1	2	-1	14
                -1	7	-1	6	-1	1	-1
                -1	-1	5	-1	3	-1	-1
                -1	-1	-1	4	-1	-1	-1
                ];
        elseif case_number ==5
            initial_placement = [-1	-1	-1	3	-1	-1	-1
                -1	-1	2	-1	14	-1	-1
                -1	5	-1	1	-1	15	-1
                4	-1	7	-1	11	-1	16
                -1	6	-1	9	-1	13	-1
                -1	-1	8	-1	12	-1	-1
                -1	-1	-1	10	-1	-1	-1
                ];
        elseif case_number ==6
            initial_placement = [-1	-1	-1	11	-1	-1	-1
                -1	-1	12	-1	16	-1	-1
                -1	8	-1	13	-1	15	-1
                9	-1	10	-1	2	-1	14
                -1	7	-1	6	-1	1	-1
                -1	-1	5	-1	3	-1	-1
                -1	-1	-1	4	-1	-1	-1
                ];
        end
    elseif arch =='t-arch'
        case_number = randi(6);
        if case_number == 1
            initial_placement = [11	8	9	5
                12	10	7	6
                13	16	1	4
                15	14	3	2
                ];
        elseif case_number ==2
            initial_placement = [11	8	9	5
                12	10	7	6
                13	16	1	4
                15	14	3	2
                ];
        elseif case_number ==3
            initial_placement = [15	14	1	3
                16	6	4	2
                13	5	7	9
                11	12	10	8
                ];
        elseif case_number ==4
            initial_placement = [15	14	1	3
                16	6	4	2
                13	5	7	9
                11	12	10	8
                ];
        elseif case_number ==5
            initial_placement = [11	8	9	5
                12	10	7	6
                13	16	1	4
                15	14	3	2
                ];
        elseif case_number ==6
            initial_placement = [15	14	1	3
                16	6	4	2
                13	5	7	9
                11	12	10	8
                ];
        end
    end
elseif algorithm== 6
    if arch =='prop_1'
        %% 경우의 수는 다음과 같음
        % case 1,2 인 경우 : [10	12	8	9	15	14	6	2	4	13	7	1	3	11	5]
        % case 3 인 경우 : [7	3	1	11	2	5	6	15	4	9	10	8	13	12	14]
        case_number = randi(6);
        if case_number ==1
            initial_placement = [2	1	3	4	5	6	7	8	9	10	11	12	13	14	18	16	17	15];
        elseif case_number ==2
            initial_placement = [2	1	3	4	5	6	7	8	9	10	11	12	13	14	18	16	17	15];
        elseif  case_number ==3
            initial_placement = [5	4	3	1	2	6	7	8	9	10	11	12	14	13	15	17	16	18];
        elseif case_number ==4
            initial_placement = [5	4	3	1	2	6	7	8	9	10	11	12	14	13	15	17	16	18];
        elseif case_number ==5
            initial_placement = [2	1	3	4	5	6	7	8	9	10	11	12	13	14	18	16	17	15];
        elseif case_number ==6
            initial_placement = [5	4	3	1	2	6	7	8	9	10	11	12	14	13	15	17	16	18];
        end
    elseif arch == 'c-arch' %% 여기만 작성되면 main_integrated [[15,1,3]]을 돌릴 수 있음
        case_number = randi(6);
        if case_number == 1
            initial_placement = [-1	-1	-1	-1	6	-1	-1	-1	-1
                -1	-1	-1	7	-1	4	-1	-1	-1
                -1	-1	8	-1	5	-1	1	-1	-1
                -1	10	-1	9	-1	3	-1	2	-1
                22	-1	11	-1	14	-1	19	-1	24
                -1	25	-1	13	-1	20	-1	21	-1
                -1	-1	12	-1	15	-1	23	-1	-1
                -1	-1	-1	17	-1	16	-1	-1	-1
                -1	-1	-1	-1	18	-1	-1	-1	-1
                ];
        elseif case_number ==2
            initial_placement =  [-1	-1	-1	-1	6	-1	-1	-1	-1
                -1	-1	-1	7	-1	4	-1	-1	-1
                -1	-1	8	-1	5	-1	1	-1	-1
                -1	10	-1	9	-1	3	-1	2	-1
                22	-1	11	-1	14	-1	19	-1	24
                -1	25	-1	13	-1	20	-1	21	-1
                -1	-1	12	-1	15	-1	23	-1	-1
                -1	-1	-1	17	-1	16	-1	-1	-1
                -1	-1	-1	-1	18	-1	-1	-1	-1
                ];
        elseif case_number ==3
            initial_placement = [-1	-1	-1	-1	18	-1	-1	-1	-1
                -1	-1	-1	16	-1	15	-1	-1	-1
                -1	-1	6	-1	17	-1	14	-1	-1
                -1	4	-1	8	-1	13	-1	12	-1
                5	-1	7	-1	9	-1	11	-1	24
                -1	3	-1	2	-1	10	-1	21	-1
                -1	-1	1	-1	19	-1	20	-1	-1
                -1	-1	-1	25	-1	22	-1	-1	-1
                -1	-1	-1	-1	23	-1	-1	-1	-1
                ];
        elseif case_number ==4
            initial_placement = [-1	-1	-1	-1	18	-1	-1	-1	-1
                -1	-1	-1	16	-1	15	-1	-1	-1
                -1	-1	6	-1	17	-1	14	-1	-1
                -1	4	-1	8	-1	13	-1	12	-1
                5	-1	7	-1	9	-1	11	-1	24
                -1	3	-1	2	-1	10	-1	21	-1
                -1	-1	1	-1	19	-1	20	-1	-1
                -1	-1	-1	25	-1	22	-1	-1	-1
                -1	-1	-1	-1	23	-1	-1	-1	-1
                ];
        elseif case_number ==5
            initial_placement = [-1	-1	-1	-1	6	-1	-1	-1	-1
                -1	-1	-1	7	-1	4	-1	-1	-1
                -1	-1	8	-1	5	-1	1	-1	-1
                -1	10	-1	9	-1	3	-1	2	-1
                22	-1	11	-1	14	-1	19	-1	24
                -1	25	-1	13	-1	20	-1	21	-1
                -1	-1	12	-1	15	-1	23	-1	-1
                -1	-1	-1	17	-1	16	-1	-1	-1
                -1	-1	-1	-1	18	-1	-1	-1	-1
                ];
        elseif case_number ==6
            initial_placement = [-1	-1	-1	-1	18	-1	-1	-1	-1
                -1	-1	-1	16	-1	15	-1	-1	-1
                -1	-1	6	-1	17	-1	14	-1	-1
                -1	4	-1	8	-1	13	-1	12	-1
                5	-1	7	-1	9	-1	11	-1	24
                -1	3	-1	2	-1	10	-1	21	-1
                -1	-1	1	-1	19	-1	20	-1	-1
                -1	-1	-1	25	-1	22	-1	-1	-1
                -1	-1	-1	-1	23	-1	-1	-1	-1
                ];
        end
    elseif arch =='t-arch'
        case_number = randi(6);
        if case_number == 1
            initial_placement = [22	20	2	1	3
                18	19	25	21	4
                17	14	8	7	5
                15	13	11	9	6
                16	12	10	24	23
                ];
        elseif case_number ==2
            initial_placement = [22	20	2	1	3
                18	19	25	21	4
                17	14	8	7	5
                15	13	11	9	6
                16	12	10	24	23
                ];
        elseif case_number ==3
            initial_placement = [18	17	16	10	20
                14	15	13	11	12
                3	5	7	9	25
                1	4	6	8	21
                2	23	19	22	24
                ];
        elseif case_number ==4
            initial_placement = [18	17	16	10	20
                14	15	13	11	12
                3	5	7	9	25
                1	4	6	8	21
                2	23	19	22	24
                ];
        elseif case_number ==5
            initial_placement = [22	20	2	1	3
                18	19	25	21	4
                17	14	8	7	5
                15	13	11	9	6
                16	12	10	24	23
                ];
        elseif case_number ==6
            initial_placement = [18	17	16	10	20
                14	15	13	11	12
                3	5	7	9	25
                1	4	6	8	21
                2	23	19	22	24
                ];
        end
    end
elseif algorithm== 7
    if arch =='prop_1'
        %% 경우의 수는 다음과 같음
        % case 1,2 인 경우 : [10	12	8	9	15	14	6	2	4	13	7	1	3	11	5]
        % case 3 인 경우 : [7	3	1	11	2	5	6	15	4	9	10	8	13	12	14]
        disp("불가능. Sorted 이용 필요")
    elseif arch == 'c-arch' %% 여기만 작성되면 main_integrated [[15,1,3]]을 돌릴 수 있음
        case_number = randi(2);
        if case_number == 1
            initial_placement = [-1	-1	-1	-1	24	-1	-1	-1	-1
                -1	-1	-1	14	-1	12	-1	-1	-1
                -1	-1	17	-1	15	-1	13	-1	-1
                -1	16	-1	1	-1	3	-1	11	-1
                23	-1	19	-1	4	-1	10	-1	2
                -1	25	-1	21	-1	6	-1	8	-1
                -1	-1	18	-1	20	-1	9	-1	-1
                -1	-1	-1	5	-1	7	-1	-1	-1
                -1	-1	-1	-1	22	-1	-1	-1	-1
                ];
        elseif case_number ==2
            initial_placement =  [-1	-1	-1	-1	24	-1	-1	-1	-1
                -1	-1	-1	3	-1	17	-1	-1	-1
                -1	-1	18	-1	19	-1	16	-1	-1
                -1	5	-1	1	-1	15	-1	22	-1
                2	-1	21	-1	13	-1	12	-1	23
                -1	20	-1	10	-1	14	-1	25	-1
                -1	-1	8	-1	11	-1	6	-1	-1
                -1	-1	-1	9	-1	4	-1	-1	-1
                -1	-1	-1	-1	7	-1	-1	-1	-1
                ];
        end
    elseif arch =='t-arch'
        case_number = randi(2);
        if case_number == 1
            initial_placement = [5	21	18	25	24
                20	19	1	4	23
                16	17	14	2	22
                3	13	15	12	6
                11	10	9	8	7
                ];
        elseif case_number ==2
            initial_placement = [23	16	17	15	13
                1	19	4	14	12
                20	18	8	11	2
                5	21	9	3	10
                25	22	6	7	24
                ];
            
        end
    end
end
end