 % Display header for the first semester calculations 
('---SEMESTER 1 GPA CALCULATION---'); 
% Prompt user for the total number of courses in Semester 1 
n1 = input('Enter number of courses for Semester 1: '); 

% Initialize cumulative tracking variables for Semester 1 
total_points = 0; 
total_credits1 = 0; 
% Arrays to store data for plotting
sem1_grades = zeros(1, n1);
sem1_credits = zeros(1, n1);

% Loop through each course to gather credit hours and grade points 
for i = 1:n1 
    fprintf('Course %d:\n',i); 
    credits = input('Enter credit hours: '); 
    grade_point = input('Enter grade points: '); 
    
    % Store values for 2D plots
    sem1_grades(i) = grade_point;
    sem1_credits(i) = credits;
    
    % Accumulate total quality points (credits multiplied by grade points) 
    total_points = total_points + (credits * grade_point); 
    % Accumulate total credit hours for Semester 1 
    total_credits1 = total_credits1 + credits; 
end 
% Calculate the Grade Point Average for Semester 1 
sem1_gpa = total_points / total_credits1; 
% Output the calculated Semester 1 GPA to the user 
fprintf('Your Semester 1 GPA is: %.2f\n\n', sem1_gpa); 

% Display header for the second semester calculations 
disp('---SEMESTER 2 GPA CALCULATION---'); 
% Prompt user for the total number of courses in Semester 2 
n2 = input('Enter number of courses for semester 2: '); 

% Initialize cumulative tracking variables for Semester 2 
total_points2 = 0; 
total_credits2 = 0; 
% Arrays to store data for plotting
sem2_grades = zeros(1, n2);
sem2_credits = zeros(1, n2);

% Loop through each course to gather credit hours and grade points for Semester 2 
for i = 1:n2 
    fprintf('Course %d:\n',i); 
    credits = input('enter credit hours: '); 
    grade_point = input('enter grade points: '); 
    
    % Store values for 2D plots
    sem2_grades(i) = grade_point;
    sem2_credits(i) = credits;
    
    % Accumulate total quality points for Semester 2 
    total_points2 = total_points2 + (credits * grade_point); 
    % Accumulate total credit hours for Semester 2 
    total_credits2 = total_credits2 + credits; 
end 
% Calculate the Grade Point Average for Semester 2 
sem2_gpa = total_points2 / total_credits2; 
% Output the calculated Semester 2 GPA to the user 
fprintf('Your semester 2 GPA is: %.2f\n\n', sem2_gpa); 

% Combine quality points and credit hours across both semesters for CGPA 
grand_total_points = total_points + total_points2; 
grand_total_credits = total_credits1 + total_credits2; 
% Calculate the final Cumulative Grade Point Average 
cgpa = grand_total_points / grand_total_credits; 

% Output the final cumulative CGPA results formatted with a border 
fprintf('---\n'); 
fprintf('your cumulative CGPA is: %.2f\n', cgpa); 
fprintf('---\n');

%% --- 2D PLOTTING Section---


% Plot 1: Semester 1 Course-wise Grade Points
figure;
bar(sem1_grades);
title('Semester 1: Course Grades');
xlabel('Course Number');
ylabel('Grade Points');
grid on;

% Plot 2: Semester 2 Course-wise Grade Points
figure;
bar(sem2_grades);
title('Semester 2: Course Grades');
xlabel('Course Number');
ylabel('Grade Points');
grid on;

% Plot 3: GPA & CGPA Summary Comparison (Spans across 2 columns)
figure;
gpa_data = [sem1_gpa, sem2_gpa, cgpa];
% 1. Pair your labels directly with the data using categorical arrays
labels = categorical({'Semester 1 GPA', 'Semester 2 GPA', 'Overall CGPA'});

% 2. Plot the data
bar(labels, [sem1_gpa, sem2_gpa, cgpa]);
title('Overall GPA Summary');
ylabel('Grade Point Average');
ylim([0 5]); 
grid on;