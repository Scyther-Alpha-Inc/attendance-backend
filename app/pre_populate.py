import asyncio
from .db.database_session import sessionmanager
from .models.department import Department
from .models.course import Course
from .models.user import User
from .repositories.course_repo import CourseRepo
from .repositories.department_repo import DepartmentRepo
from .repositories.user_repo import UserRepo
from core.security.password_handler import PasswordHandler
import logging

logger = logging.getLogger(__name__)
lecturers = [
    {
        "gctu_id": "L001",
        "name": "Dr. Mensah",
        "email": "mensah@gctu.edu.gh",
        "pin": "111111",
        "role": "lecturer",
    }
]


courses = [
    {
        "code": "CSCS422",
        "title": "Information Systems Audit",
    }
]
users = [
    {
        "gctu_id": "GCTU12345",
        "name": "Ama Mensah",
        "program": "BSc Computer Science",
        "pin": "222222",
        "role": "student",
    },
    {
        "gctu_id": "GCTU12346",
        "name": "Kofi Adjei",
        "program": "BSc Computer Science",
        "pin": "222222",
        "role": "student",
    },
    {
        "gctu_id": "GCTU12347",
        "name": "Yaw Owusu",
        "program": "BSc Computer Science",
        "pin": "333333",
        "role": "student",
    },
    {
        "gctu_id": "GCTU12348",
        "name": "Akosua Boateng",
        "program": "BSc Computer Science",
        "pin": "444444",
        "role": "student",
    },
    {
        "gctu_id": "GCTU12349",
        "name": "Kwame Nkrumah",
        "program": "BSc Computer Science",
        "pin": "555555",
        "role": "student",
    },
]

departments = [
    {
        "code": "PRG1",
        "name": "BSc Computer Science",
        "courses": courses,
    },
]
# enrollments = [
#     {"course_id": "C001", "student_id": "GCTU12345"},
#     {"course_id": "C001", "student_id": "GCTU12346"},
#     {"course_id": "C001", "student_id": "GCTU12347"},
#     {"course_id": "C001", "student_id": "GCTU12348"},
#     {"course_id": "C001", "student_id": "GCTU12349"},
# ]


async def pre_populate():
    async with sessionmanager.session() as session:

        user_repo = UserRepo(session)
        department_repo = DepartmentRepo(session)


        department_models = []
        for department in departments:
            # Convert courses dictionaries to Course model objects
            department_data = department.copy()
            if "courses" in department_data:
                courses_models = [
                    Course.model_validate(course)
                    for course in department_data["courses"]
                ]
            department = Department.model_validate(department_data)
            department.courses = courses_models
            department_models.append(department)
        
        logger.info(f"department_models: {department_models} {'<-*->'*400}")
        
        try:
            await department_repo.bulk_create(department_models)
        except Exception as e:
            logger.error(e)
            logger.error(department_models)

        try:
            await department_repo.bulk_create(department_models)
        except Exception as e:
            logger.error(e)
            logger.error(department_models)
            
        lecturer_models = []
        for lecturer in lecturers:
            lecturer["pin"] = PasswordHandler.hash(lecturer["pin"])
            lecturer_models.append(User(**lecturer))
        try:
            await user_repo.bulk_create(lecturer_models)
        except Exception as e:
            logger.error(e)
            logger.error(lecturer_models)

        student_models = []
        for user in users:
            user["pin"] = PasswordHandler.hash(user["pin"])
            student_models.append(User(**user))
        try:
            await user_repo.bulk_create(student_models)
        except Exception as e:
            logger.error(e)
            logger.error(student_models)
        # for class_model in class_models:
        #     await class_repo.create(Class(**class_model))
        # for course in courses:
        #     await course_repo.create(Course(**course))
