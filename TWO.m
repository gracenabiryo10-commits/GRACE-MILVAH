% Display header for the first semester calculations
disp('---SEMESTER 1 GPA CALCULATION---'); 

% Prompt user for the total number of courses in Semester 1
n1 = input('Enter number of courses for Semester 1:'); 

% Initialize cumulative tracking variables for Semester 1
total_points = 0; 
total_credits1 = 0; 

% Loop through each course to gather credit hours and grade points
for i = 1:n1 
    fprintf('Course %d:\n',i); 
    credits = input('Enter credit hours:'); 
    grade_point = input('Enter grade points:'); 
    
    % Accumulate total quality points (credits multiplied by grade points)
    total_points = total_points +(credits * grade_point); 
    
    % Accumulate total credit hours for Semester 1
    total_credits1= total_credits1 + credits; 
end 

% Calculate the Grade Point Average for Semester 1
sem1_gpa = total_points /total_credits1; 

% Output the calculated Semester 1 GPA to the user
fprintf('Your Semester 1 GPA is: %2f\n\n',sem1_gpa); 

% Display header for the second semester calculations
disp('---SEMESTER 2 GPA CALCULATION---'); 

% Prompt user for the total number of courses in Semester 2
n2 = input('Enter number of courses for semester 2:'); 

% Initialize cumulative tracking variables for Semester 2
total_points2 = 0; 
total_credits2 = 0; 

% Loop through each course to gather credit hours and grade points for Semester 2
for i = 1:n2 
    fprintf('Course %d:\n',i); 
    credits = input('enter credit hours:'); 
    grade_point = input('enter grade points:'); 
    
    % Accumulate total quality points for Semester 2
    total_points2 = total_points2 + (credits * grade_point); 
    
    % Accumulate total credit hours for Semester 2
    total_credits2 = total_credits2 + credits; 
end 

% Calculate the Grade Point Average for Semester 2
sem2_gpa = total_points2 /total_credits2; 

% Output the calculated Semester 2 GPA to the user
fprintf('Your semester 2 GPA is: %.2f\n\n',sem2_gpa); 

% Combine quality points and credit hours across both semesters for CGPA
grand_total_points = total_points + total_points2; 
grand_total_credits = total_credits1 + total_credits2; 

% Calculate the final Cumulative Grade Point Average
cgpa = grand_total_points/grand_total_credits; 

% Output the final cumulative CGPA results formatted with a border
fprintf('---\n'); 
fprintf('your cumulative CGPA is:%.2f\n',cgpa); 
fprintf('---\n');
