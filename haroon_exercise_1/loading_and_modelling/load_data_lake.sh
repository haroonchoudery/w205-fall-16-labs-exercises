# Remove header line from files and rename to make it easier to interpret. Move trimmed files to trimmed_raw_files folder
tail -n +2 raw_files/Hospital\ General\ Information.csv > trimmed_raw_files/hospitals.csv
tail -n +2 raw_files/Timely\ and\ Effective\ Care\ -\ Hospital.csv > trimmed_raw_files/effective_care.csv
tail -n +2 raw_files/Readmissions\ and\ Deaths\ -\ Hospital.csv > trimmed_raw_files/readmissions.csv
tail -n +2 raw_files/Measure\ Dates.csv > trimmed_raw_files/measures.csv
tail -n +2 raw_files/hvbp_hcahps_05_28_2015.csv > trimmed_raw_files/survey_responses.csv

# Upload raw files folder to /home/w205 folder
scp -i ~/ucb205.pem -r trimmed_raw_files root@ec2-52-90-144-232.compute-1.amazonaws.com:/home/w205/hospital-compare

# Start instance, mount drive, and start up HDFS and PostGres
cd ~
chmod 400 ucb205.pem
ssh -i "ucb205.pem" root@ec2-52-90-144-232.compute-1.amazonaws.com
mount -t ext4 /dev/xvdf /data

/root/start-hadoop.sh 
/data/start_postgres.sh

# Change to w205 User
su - w205

# Make proper directory in HDFS
hdfs dfs -mkdir /user/w205/hospital_compare
hdfs dfs -mkdir /user/w205/hospital_compare/effective_care
hdfs dfs -mkdir /user/w205/hospital_compare/hospitals
hdfs dfs -mkdir /user/w205/hospital_compare/measures
hdfs dfs -mkdir /user/w205/hospital_compare/readmissions
hdfs dfs -mkdir /user/w205/hospital_compare/survey_responses

# Move files from /home/w205 folder to HDFS hospital_compare folder
hdfs dfs -put /home/w205/hospital-compare/trimmed_raw_files/effective_care.csv /user/w205/hospital_compare/effective_care
hdfs dfs -put /home/w205/hospital-compare/trimmed_raw_files/hospitals.csv /user/w205/hospital_compare/hospitals
hdfs dfs -put /home/w205/hospital-compare/trimmed_raw_files/measures.csv /user/w205/hospital_compare/measures
hdfs dfs -put /home/w205/hospital-compare/trimmed_raw_files/readmissions.csv /user/w205/hospital_compare/readmissions
hdfs dfs -put /home/w205/hospital-compare/trimmed_raw_files/survey_responses.csv /user/w205/hospital_compare/survey_responses