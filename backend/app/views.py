from django.shortcuts import render
from django.http import JsonResponse, HttpResponse
from django.db import connection
from django.views.decorators.csrf import csrf_exempt
import random
import json
import os, time
from django.conf import settings
from django.core.files.storage import FileSystemStorage

@csrf_exempt
def getusers(request):
    if request.method != "GET":
        HttpResponse(status=404)
    lookup = request.GET.getlist('ids')
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
    user1 = json_data['user1']
    user2 = json_data['user2']
    cursor = connection.cursor()
    cursor.execute("INSERT INTO SAVED (userID, saved_userID) VALUES(%s,%s);", (user1,user2))
    response = {}
    return JsonResponse(response)


@csrf_exempt
def unlikeprofile(request):
    if request.method != "POST":
        HttpResponse(status=404)
    json_data = json.loads(request.body)
    user1 = json_data['user1']
    user2 = json_data['user2']
    cursor = connection.cursor()
    cursor.execute("DELETE FROM saved WHERE userID=(%s) AND saved_userID=(%s);", (user1,user2))
    return JsonResponse({})


# @csrf_exempt
# def editprofile(request):
#    if request.method != "POST":
#       HttpResponse(status=404)
#    userID = request.POST.get('userID')
#    employer = request.POST.get('employer')
#    age = request.POST.get('age')
#    gender = request.POST.get('gender')
#    industry = request.POST.get('industry')
#    education = request.POST.get('education')
#    location = request.POST.get('location')
#    interests = request.POST.get('interests')
#    bio = request.POST.get('bio')
#    profpic = request.FILES['profpic']

    # do the filename stuff
#    filename = str(userID)+".jpeg"
#    fs = FileSystemStorage()
#    filename = fs.save(filename, profpic)
#    imageurl = fs.url(filename)
    
#    attr = [employer, age, gender, industry, education, interests, bio, imageurl, location, userID]
#    cursor = connection.cursor()
#    cursor.execute(
#        "UPDATE info SET employer=(%s), age=(%s), gender=(%s), industry=(%s), education=(%s), interests=(%s), bio=(%s), profpic=(%s), location=(%s)  WHERE userid=(%s);",tuple(attr)
#    )
#    return JsonResponse({})

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
    location = json_data['location']
    interests = json_data['interests']
    bio = json_data['bio']
    profpic = json_data['profpic']
    privacyOn = json_data['privacyOn']

    attr = [employer, age, gender, industry, education, interests, bio, profpic, location,privacyOn, userID]
    cursor = connection.cursor()
    cursor.execute(
        "UPDATE info SET employer=(%s), age=(%s), gender=(%s), industry=(%s), education=(%s), interests=(%s), bio=(%s), profpic=(%s), location=(%s), privacyOn=(%s)  WHERE userid=(%s);",tuple(attr)
    )
    return JsonResponse({})

@csrf_exempt
def getprofile(request):
    if request.method != "GET":
        HttpResponse(status=404)
    lookup = request.GET['id']
    logname = request.GET['logname']
    cursor = connection.cursor()
    cursor.execute('SELECT name, phonenum, email FROM users where userID = (%s);',(lookup,))
    user_info = cursor.fetchall()[0]
    cursor.execute('SELECT * FROM info where userID = (%s);',(lookup,))
    info_info = cursor.fetchall()[0]
    cursor.execute('SELECT * FROM saved WHERE userID=(%s) AND saved_userID=(%s);', (logname, lookup))
    response = {}
    response['user'] = user_info + info_info + (len(cursor.fetchall()) > 0,)
    return JsonResponse(response)

@csrf_exempt
def getNearbyProfile(request):
    if request.method != "GET":
        HttpResponse(status=404)
    lookup = request.GET['name']
    logname = request.GET['logname']
    cursor = connection.cursor()
    cursor.execute('SELECT name, phonenum, email FROM users where name=(%s);',(lookup,))
    user_info = cursor.fetchall()[0]
    cursor.execute('SELECT userID from users where name=(%s);',(logname,))
    firstID = cursor.fetchall()[0]
    cursor.execute('SELECT userID from users where name=(%s);',(lookup,))
    secondID = cursor.fetchall()[0]
    cursor.execute('SELECT * FROM info where userID =(%s);',(secondID,))
    info_info = cursor.fetchall()[0]
    # make sure the logged in user only gets somewhat similar users
    cursor.execute('SELECT * FROM info where userID =(%s);',(firstID,))
    logname_info = cursor.fetchall()[0]
    info_dct = dict((x, y) for x, y in info_info)
    logname_dct = dict((x, y) for x, y in logname_info)
    if info_dict['industry'] != logname_dict['industry'] and info_dict['interests'] != logname_dict['interests'] and info_dict['education'] != logname_dict['education']:
        sim_score = 0
    elif info_dict['industry'] != logname_dict['industry'] and info_dict['interests'] != logname_dict['interests']:
        sim_score = 1
    elif info_dict['interests'] != logname_dict['interests'] and info_dict['education'] != logname_dict['education']:
        sim_score = 1
    elif info_dict['industry'] != logname_dict['industry'] and info_dict['education'] != logname_dict['education']:
        sim_score = 1
    elif info_dict['industry'] == logname_dict['industry'] and info_dict['interests'] == logname_dict['interests'] and info_dict['education'] == logname_dict['education']:
        sim_score = 3
    else:
        sim_score = 2
    cursor.execute('SELECT * FROM saved WHERE userID=(%s) AND saved_userID=(%s);', (firstID, secondID))
    response = {}
    response['user'] = user_info + info_info + (len(cursor.fetchall()) > 0,) + (sim_score,)
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
        cursor.execute('SELECT industry FROM info WHERE userid = (%s);', (user,))
        to_add2 = cursor.fetchall()
        if not to_add2:
            continue
        all_users.append(to_add[0] + to_add2[0])
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
    tags = ' '
    email = json_data['email']
    cursor = connection.cursor()
    cursor.execute('INSERT INTO users (userid, name, phonenum, email, password, tags) VALUES(%s,%s,%s,%s,%s,%s);',(userid, username, phonenum, email, password, tags))
    cursor.execute('INSERT INTO info VALUES(%s, %s, %s, %s, %s, %s, %s, %s, %s, %s);', (userid, " ", 0, " ", " ", " ", " ", " ", " ", " "))
    return JsonResponse({})
