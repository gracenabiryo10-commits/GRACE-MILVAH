%Reading the excel sheet 
n_file = readtable("C:\Users\user\Documents\MATLAB\GROUP5.xlsx");
%Outputting plots from the given data
names_cat = categorical(n_file.Fullname,n_file.Fullname);
n_age = n_file.age;
barh(names_cat,n_age);
xlabel('Names of Student');
ylabel('Ages');
title('A bar plot');
grid on;
%Plotting the tribe counts
tribe_counts = groupcounts(n_file,'tribe');
figure;
bar(categorical(tribe_counts.tribe),tribe_counts.GroupCount);
title('distribution by tribe');
xlabel('tribe');
ylabel('Count');
grid on;
%Outputting a plot of hobbies of the students%
hobby_counts = groupcounts(n_file,'Hobby');
figure;
bar(categorical(hobby_counts.Hobby),hobby_counts.GroupCount);
title('Distribution Of Hobbies');
xlabel('Hobby');
ylabel('Count');
grid on;
%hostel counts%

hostel_counts = groupcounts(n_file,'hostel');
figure;
bar(categorical(hostel_counts.hostel),hostel_counts.GroupCount);
title('Distribution by Hostel');
xlabel('Hostel');
ylabel('Count');
grid on;