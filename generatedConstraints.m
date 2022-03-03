function [cineq, ceq, cineqGrad, ceqGrad] = generatedConstraints(InputVariables)
% GENERATEDCONSTRAINTS 제약 조건 값을 구합니다.
% 
% 이 함수는 제약 조건의 값을 구합니다.
% 제약 조건의 기울기 계산을 추가하려면 생성된 코드를 업데이트하십시오.
% 
% [CINEQ, CEQ] = generatedConstraints(INPUTVARIABLES) 은(는) 점
% INPUTVARIABLES에서 부등식 제약 조건 값 CINEQ과(와) 등식 제약 조건 값 CEQ을(를) 구
% 합니다.
% 
% [CINEQ, CEQ, CINEQGRAD, CEQGRAD] = generatedConstraints(INPUTVARIABLES)
% 은(는) 현재 점에서 부등식 제약 조건 기울기 값 CINEQGRAD과(와) 등식 제약 조건 기울기
% 값 CEQGRAD을(를) 추가로 구합니다.
% 
% prob2struct에 의해 21-Dec-2021 23:22:50에 자동 생성됨
% 
% 

%% 변수 인덱스입니다.
idx_w1 = 1;
idx_x = 2;

%% 솔버 기반 변수를 문제 기반 변수에 매핑합니다.
w1 = InputVariables(idx_w1);
x = InputVariables(idx_x);


%% 여기에 기울기 계산을 입력합니다.
% 기울기를 제공할 경우 솔버가 인지할 수 있도록 SpecifyConstraintGradient 옵션을
% true로 설정하십시오.
if nargout > 2
    cineqGrad = [];
    ceqGrad = [];
end

%% 부등식 제약 조건을 구합니다.
cineq = [];

%% 등식 제약 조건을 구합니다.
optim_problemdef_LHS = exp(sum(x, 1));
optim_problemdef_RHS = 1;

ceq = optim_problemdef_LHS - optim_problemdef_RHS;


end