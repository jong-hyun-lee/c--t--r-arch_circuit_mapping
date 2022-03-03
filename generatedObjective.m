function [obj, grad] = generatedObjective(inputVariables, extraParams)
% GENERATEDOBJECTIVE 목적 함수 값을 구합니다.
% 
% 이 함수는 목적 함수의 값을 구합니다.
% 목적 함수의 기울기 계산을 추가하려면 생성된 코드를 업데이트하십시오.
% 
% OBJ = generatedObjective(INPUTVARIABLES, EXTRAPARAMS) 은(는) EXTRAPARAMS의
% 추가 파라미터를 사용하여 점 INPUTVARIABLES에서 목적 함수 값 OBJ을(를) 구합니다.
% 
% [OBJ, GRAD] = generatedObjective(INPUTVARIABLES, EXTRAPARAMS) 은(는) 현재
% 점에서 목적 함수의 기울기 값 GRAD을(를) 추가로 구합니다.
% 
% prob2struct에 의해 21-Dec-2021 23:22:50에 자동 생성됨
% 
% 

%% 여기에 기울기 계산을 입력합니다.
% 기울기를 제공할 경우 솔버가 인지할 수 있도록 SpecifyObjectiveGradient 옵션을 true
% 로 설정하십시오.
if nargout > 1
    grad = [];
end

%% 목적 함수를 구합니다.
obj = extraParams{1}'*inputVariables(:);

end