my_group = readtable('C:\Users\user\Desktop\matlab assignment.xlsx');
%Outputting this excel sheet into a new one%
writetable(my_group,'MEB2_GROUP5.xlsx');
%Outputting plots in the above information%
names_cat = categorical(my_group.Fullname,my_group.Fullname);
n_age = my_group.age;
bar(names_cat,n_age);
xlabel('Names of Student');
ylabel('Ages');
xlabel('Names of Student');
tribe_counts = groupcounts(my_group,'tribe');
figure;
bar(categorical(tribe_counts.tribe),tribe_counts.GroupCount);
title('distribution by tribe');
xlabel('tribe');
ylabel('Count');
%Outputting a plot of hobbies of the students%
hobby_counts = groupcounts(my_group,'Hobby');
figure;
bar(categorical(hobby_counts.Hobby),hobby_counts.GroupCount);
title('Distribution Of Hobbies');
xlabel('Hobby');
ylabel('Count');
%hostel counts%

hostel_counts = groupcounts(my_group,'hostel');
figure;
bar(categorical(hostel_counts.hostel),hostel_counts.GroupCount);
title('Distribution by Hostel');
xlabel('Hostel');
ylabel('Count');
