
DROP DATABASE chaitanya_training_360;

CREATE DATABASE chaitanya_training_360;

\c chaitanya_training_360;

CREATE TABLE mst_zone
(
    zone_id serial NOT NULL,
    zone_name varchar NOT NULL,
    is_active boolean NOT NULL DEFAULT true,
    is_deleted boolean NOT NULL DEFAULT false,
    created_by integer,
    created_by_name varchar,
    created_on timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_by integer,
    updated_by_name varchar,
    updated_on timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (zone_id)
);

CREATE TABLE mst_cluster
(
    cluster_id serial NOT NULL,
    cluster_name varchar NOT NULL,
    zone_id integer NOT NULL,
    is_active boolean NOT NULL DEFAULT true,
    is_deleted boolean NOT NULL DEFAULT false,
    created_by integer,
    created_by_name varchar,
    created_on timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_by integer,
    updated_by_name varchar,
    updated_on timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (cluster_id),
    CONSTRAINT mc_zone_id FOREIGN KEY(zone_id) REFERENCES mst_zone(zone_id)
);

CREATE TABLE mst_region
(
    region_id serial NOT NULL,
    region_name varchar NOT NULL,
    zone_id integer NOT NULL,
    cluster_id integer NOT NULL,
    is_active boolean NOT NULL DEFAULT true,
    is_deleted boolean NOT NULL DEFAULT false,
    created_by integer,
    created_by_name varchar,
    created_on timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_by integer,
    updated_by_name varchar,
    updated_on timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (region_id),
    CONSTRAINT mr_zone_id FOREIGN KEY(zone_id) REFERENCES mst_zone(zone_id),
    CONSTRAINT mr_cluster_id FOREIGN KEY(cluster_id) REFERENCES mst_cluster(cluster_id)
);

CREATE TABLE mst_unit
(
    unit_id serial NOT NULL,
    unit_name varchar NOT NULL,
    zone_id integer NOT NULL,
    cluster_id integer NOT NULL,
    region_id integer NOT NULL,
    is_active boolean NOT NULL DEFAULT true,
    is_deleted boolean NOT NULL DEFAULT false,
    created_by integer,
    created_by_name varchar,
    created_on timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_by integer,
    updated_by_name varchar,
    updated_on timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (unit_id),
    CONSTRAINT mu_zone_id FOREIGN KEY(zone_id) REFERENCES mst_zone(zone_id),
    CONSTRAINT mu_cluster_id FOREIGN KEY(cluster_id) REFERENCES mst_cluster(cluster_id),
    CONSTRAINT mu_region_id FOREIGN KEY(region_id) REFERENCES mst_region(region_id)
);

CREATE TABLE mst_branch
(
    branch_id serial NOT NULL,
    branch_name varchar NOT NULL,
    zone_id integer NOT NULL,
    cluster_id integer NOT NULL,
    region_id integer NOT NULL,
    unit_id integer NOT NULL,
    is_active boolean NOT NULL DEFAULT true,
    is_deleted boolean NOT NULL DEFAULT false,
    created_by integer,
    created_by_name varchar,
    created_on timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_by integer,
    updated_by_name varchar,
    updated_on timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (branch_id),
    CONSTRAINT mb_zone_id FOREIGN KEY(zone_id) REFERENCES mst_zone(zone_id),
    CONSTRAINT mb_cluster_id FOREIGN KEY(cluster_id) REFERENCES mst_cluster(cluster_id),
    CONSTRAINT mb_region_id FOREIGN KEY(region_id) REFERENCES mst_region(region_id),
    CONSTRAINT mb_unit_id FOREIGN KEY(unit_id) REFERENCES mst_unit(unit_id)
);


CREATE TABLE mst_department
(
    department_id serial NOT NULL,
    department_name varchar NOT NULL,
    department_descrption varchar NOT NULL,
    is_active boolean NOT NULL DEFAULT true,
    is_deleted boolean NOT NULL DEFAULT false,
    created_by integer,
    created_by_name varchar,
    created_on timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_by integer,
    updated_by_name varchar,
    updated_on timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (department_id)
);


CREATE TABLE mst_role
(
    role_id serial NOT NULL,
    role_name varchar NOT NULL,
    role_code varchar NOT NULL, 
	is_master_management boolean NOT NULL DEFAULT false,
	is_user_management boolean NOT NULL DEFAULT false,
	is_report boolean NOT NULL DEFAULT false,
    is_active boolean NOT NULL DEFAULT true,
    is_deleted boolean NOT NULL DEFAULT false,
    created_by integer,
    created_by_name varchar,
    created_on timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_by integer,
    updated_by_name varchar,
    updated_on timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (role_id)
);
 

CREATE TABLE mst_course
(
    course_id serial NOT NULL,
    course_name varchar NOT NULL,
    is_temporary_employee boolean NOT NULL DEFAULT true,
    is_permanent_employee boolean NOT NULL DEFAULT false,
    role_id integer NOT NULL,
    role_name varchar NOT NULL,
    is_active boolean NOT NULL DEFAULT true,
    is_deleted boolean NOT NULL DEFAULT false,
    created_by integer,
    created_by_name varchar,
    created_on timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_by integer,
    updated_by_name varchar,
    updated_on timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (course_id),
    CONSTRAINT mcr_role_id FOREIGN KEY(role_id) REFERENCES mst_role(role_id)
);


CREATE TABLE mst_course_material
(
    material_id serial NOT NULL,
    material_name varchar NOT NULL,
    material_description varchar NOT NULL,
    material_type varchar NOT NULL,
    material_url varchar NOT NULL,
    course_id integer NOT NULL,
    is_active boolean NOT NULL DEFAULT true,
    is_deleted boolean NOT NULL DEFAULT false,
    created_by integer,
    created_by_name varchar,
    created_on timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_by integer,
    updated_by_name varchar,
    updated_on timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (material_id),
    CONSTRAINT mcm_course_id FOREIGN KEY(course_id) REFERENCES mst_course(course_id)
);

CREATE TABLE mst_question_group
(
    question_group_id serial NOT NULL,
    question_group_name varchar NOT NULL,
    course_id integer NOT NULL,
    course_name varchar NOT NULL,
    is_active boolean NOT NULL DEFAULT true,
    is_deleted boolean NOT NULL DEFAULT false,
    created_by integer,
    created_by_name varchar,
    created_on timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_by integer,
    updated_by_name varchar,
    updated_on timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (question_group_id),
    CONSTRAINT mqg_course_id FOREIGN KEY(course_id) REFERENCES mst_course(course_id)
);

CREATE TABLE mst_answer_type
(
    answer_type_id serial NOT NULL,
    answer_type_name varchar NOT NULL,
    answer_type_dec varchar NOT NULL,
    is_active boolean NOT NULL DEFAULT true,
    is_deleted boolean NOT NULL DEFAULT false,
    created_by integer,
    created_by_name varchar,
    created_on timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_by integer,
    updated_by_name varchar,
    updated_on timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (answer_type_id)
);

CREATE TABLE mst_question
(
    question_id serial NOT NULL,
    question varchar NOT NULL,
    section varchar NOT NULL,
    answer_type_id integer NOT NULL,
    answer_type_name varchar NOT NULL,
    question_group_id integer NOT NULL,
    is_active boolean NOT NULL DEFAULT true,
    is_deleted boolean NOT NULL DEFAULT false,
    created_by integer,
    created_by_name varchar,
    created_on timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_by integer,
    updated_by_name varchar,
    updated_on timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (question_id),
    CONSTRAINT mq_question_group_id FOREIGN KEY(question_group_id) REFERENCES mst_question_group(question_group_id),
    CONSTRAINT mq_answer_type_id FOREIGN KEY(answer_type_id) REFERENCES mst_answer_type(answer_type_id)
);

CREATE TABLE mst_question_option
(
    question_option_id serial NOT NULL,
    question_option varchar NOT NULL,
    question_id integer NOT NULL,
    question_group_id integer NOT NULL,
    is_active boolean NOT NULL DEFAULT true,
    is_deleted boolean NOT NULL DEFAULT false,
    created_by integer,
    created_by_name varchar,
    created_on timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_by integer,
    updated_by_name varchar,
    updated_on timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (question_option_id),
    CONSTRAINT mqo_question_group_id FOREIGN KEY(question_group_id) REFERENCES mst_question_group(question_group_id),
    CONSTRAINT mqo_question_id FOREIGN KEY(question_id) REFERENCES mst_question(question_id)
);


CREATE TABLE mst_expense_category_type
(
    expense_type_id serial NOT NULL,
    expense_type_name varchar NOT NULL,
    is_active boolean NOT NULL DEFAULT true,
    is_deleted boolean NOT NULL DEFAULT false,
    created_by integer,
    created_by_name varchar,
    created_on timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_by integer,
    updated_by_name varchar,
    updated_on timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (expense_type_id)
);


CREATE TABLE txn_faq
(
    faq_id serial NOT NULL,
    faq_question varchar NOT NULL,
    faq_answer varchar NOT NULL,
    faq_type varchar NOT NULL,
    is_active boolean NOT NULL DEFAULT true,
    is_deleted boolean NOT NULL DEFAULT false,
    created_by integer,
    created_by_name varchar,
    created_on timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_by integer,
    updated_by_name varchar,
    updated_on timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (faq_id)
); 

CREATE TABLE mst_user
(
    user_id serial NOT NULL,
    user_name varchar NOT NULL,
    first_name varchar NOT NULL,
    last_name varchar NOT NULL,
    salutation varchar NOT NULL,
    is_temp_user boolean NOT NULL DEFAULT true, 
    employee_id varchar NOT NULL,
    email_id varchar NOT NULL,
    phone_number varchar NOT NULL,
    password varchar NOT NULL,
    password_default varchar NOT NULL,
    login_count integer NOT NULL DEFAULT 0,
    login_valid_count integer NOT NULL DEFAULT 0,
    login_generate_count integer NOT NULL DEFAULT 0,
    login_blocked_on timestamp,
    is_blocked boolean NOT NULL DEFAULT false, 
    is_active boolean NOT NULL DEFAULT true,
    is_deleted boolean NOT NULL DEFAULT false,
    created_by integer,
    created_by_name varchar,
    created_on timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_by integer,
    updated_by_name varchar,
    updated_on timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (lang_id)
);


CREATE TABLE mst_user_association
(
    id serial NOT NULL,
    user_id integer NOT NULL,
    role_id integer NOT NULL,
    dept_id integer NOT NULL, 
    zone_id integer NOT NULL,
    cluster_id integer,
    region_id integer,
    unit_id integer,
    branch_id integer,
    is_active boolean NOT NULL DEFAULT true,
    is_deleted boolean NOT NULL DEFAULT false,
    created_by integer,
    created_by_name varchar,
    created_on timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_by integer,
    updated_by_name varchar,
    updated_on timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (user_id)
);

CREATE TABLE mst_lang
(
    lang_id serial NOT NULL,
    lang_code varchar NOT NULL,
    lang_desc varchar NOT NULL,
    is_active boolean NOT NULL DEFAULT true,
    is_deleted boolean NOT NULL DEFAULT false,
    created_by integer,
    created_by_name varchar,
    created_on timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_by integer,
    updated_by_name varchar,
    updated_on timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (lang_id)
);

CREATE TABLE mst_band
(
    band_id serial NOT NULL,
	course_id integer NOT NULL,
	course_name varchar NOT NULL,
	region_id integer NOT NULL ,
	region_name varchar NOT NULL,
	role_id integer NOT NULL,
	role_name varchar NOT NULL,
	person_min_budget varchar NOT NULL,
	person_max_budget varchar NOT NULL,
    is_active boolean NOT NULL DEFAULT true,
    is_deleted boolean NOT NULL DEFAULT false,
    created_by integer,
    created_by_name varchar,
    created_on timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_by integer,
    updated_by_name varchar,
    updated_on timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (band_id),
	constraint mb_course_id foreign key (course_id) references mst_course(course_id),
	constraint mb_region_id foreign key (region_id) references mst_region(region_id),
	constraint mb_role_id foreign key ( role_id) references mst_role (role_id )
);


