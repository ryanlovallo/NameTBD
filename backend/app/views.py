from django.shortcuts import render
from django.http import JsonResponse, HttpResponse
from django.db import connection
from django.views.decorators.csrf import csrf_exempt
import json
import os, time
from django.conf import settings
from django.core.files.storage import FileSystemStorage

@csrf_exempt
def getusers(request):
    if request.method != "GET":
        HttpResponse(status=404)
    lookup = request.GET.getlist('id')
    cursor = connection.cursor()
    all_users = []
    for user in lookup:
        cursor.execute('SELECT * FROM users WHERE userid = (%s);',(user,))
        to_add = cursor.fetchall()
        if not to_add:
            continue
        all_users.append(to_add[0])
    response = {}
    response['users'] = all_users
    return JsonResponse(response)

@csrf_exempt
def likeprofile(request):
    if request.method != "POST":
        HttpResponse(status=404)
    json_data = json.loads(request.body)
    user1 = json_data['userID']
    user2 = json_data['liked']
    cursor = connection.cursor()
    cursor.execute("INSERT INTO SAVED (userID, saved_userID) VALUES(%s,%s);", (user1,user2))
    response = {}
    return JsonResponse(response)


@csrf_exempt
def editprofile(request):
    if request.method != "POST":
        HttpResponse(status=404)
    json_data = json.loads(request.body)
    userID = json_data['userID']
    employer = json_data['employer']
    age = json_data['age']
    gender = json_data['gender']
    industry = json_data['industry']
    education = json_data['education']
    city = json_data['city']
    state = json_data['state']
    interests = json_data['interests']
    attr = [userID, employer, age, gender, industry, education, city, state, interests]
    cursor = connection.cursor()
    cursor.execute(
        "SELECT * FROM info  WHERE userid = (%s);", (userID,)
    )
    current = cursor.fetchall()
    if len(current) == 0:
        cursor.execute(
            "INSERT INTO info (userid, employer, age, gender, industry, education, city, state, interests) VALUES (%s,%s,%s,%s,%s,%s,%s,%s,%s);",tuple(attr)
        )
    else:
        attr.pop(0)
        attr.append(userID)
        if not employer:
            attr[0] = current[0]['employer']
        if not age:
            attr[1] = current[0]['age']
        if not gender:
            attr[2] = current[0]['gender']
        if not industry:
            attr[3] = current[0]['industry']
        if not education:
            attr[4] = current[0]['education']
        if not city:
            attr[5] = current[0]['city']
        if not state:
            attr[6] = current[0]['state']
        if not interests:
            attr[7] = current[0]['interests']
        cursor.execute(
            "UPDATE info SET employer=(%s), age=(%s), gender=(%s), industry=(%s), education=(%s), city=(%s), state=(%s), interests=(%s)  WHERE userid=(%s);",tuple(attr)
        )
    return JsonResponse({})


@csrf_exempt
def editbio(request):
    if request.method != "POST":
        HttpResponse(status=404)
    json_data = json.loads(request.body)
    user = json_data['userID']
    bio = json_data['bio']
    cursor = connection.cursor()
    cursor.execute("UPDATE users SET bio=(%s) WHERE userid=(%s);", (bio,user))
    response = {}
    return JsonResponse(response)


@csrf_exempt
def getprofile(request):
    if request.method != "GET":
        HttpResponse(status=404)
    lookup = request.GET['id']
    cursor = connection.cursor()
    cursor.execute('SELECT * FROM users where userID = (%s);',(lookup,))
    profile = cursor.fetchall()
    response = {}
    response['user'] = profile
    return JsonResponse(response)


@csrf_exempt
def getlikes(request):
    if request.method != "GET":
        HttpResponse(status=404)
    lookup = request.GET["id"]
    cursor = connection.cursor()
    cursor.execute('SELECT saved_userid FROM saved where userID = (%s) ORDER BY time DESC;',(lookup,))
    liked = cursor.fetchall()
    all_users = []
    for user in liked:
        cursor.execute('SELECT * FROM users WHERE userID = (%s);',(user,))
        to_add = cursor.fetchall()
        if not to_add:
            continue
        all_users.append(to_add[0])
    response = {}
    response['users'] = all_users
    return JsonResponse(response)

@csrf_exempt
def createuser(request):
    if request.method != "POST":
        HttpResponse(status=404)
    json_data = json.loads(request.body)
    userid = json_data['userid']
    password = json_data['password']
    username = json_data['username']
    phonenum = json_data['number']
    profpic = json_data['profpic']
    email = json_data['email']
    cursor = connection.cursor()
    cursor.execute('INSERT INTO users (userid, name, phonenum, email, password, profpic) VALUES(%s,%s,%s,%s,%s,%s);',(userid, username, phonenum, email, password, profpic))
    return JsonResponse({})
