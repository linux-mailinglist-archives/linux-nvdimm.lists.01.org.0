Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 13352214994
	for <lists+linux-nvdimm@lfdr.de>; Sun,  5 Jul 2020 04:05:45 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 0B08610FC4479;
	Sat,  4 Jul 2020 19:05:43 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::441; helo=mail-pf1-x441.google.com; envelope-from=hopelight1305@gmail.com; receiver=<UNKNOWN> 
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 866CC10FC3710
	for <linux-nvdimm@lists.01.org>; Sat,  4 Jul 2020 19:05:39 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id t11so10648888pfq.11
        for <linux-nvdimm@lists.01.org>; Sat, 04 Jul 2020 19:05:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:list-unsubscribe:mime-version:from:to:subject
         :content-transfer-encoding;
        bh=YIYu/a+zEmG7g8Bdw7Ubgi4J3ukBXf/o4jupCSVN0vE=;
        b=VyAZHChA7iWhVo2uLCU1jOo7yXyLCVlP6aGG2tUHGAW5gtY7tfclO3fbWsR1WUdpU/
         ZZxTb270WQYGIF1amiHWeuJegycOXRh+Ut0LqsO5GmmUBqEIRNxdSXIyPCeacSt+CKck
         nlosp0VyQSGIiflCMPdr6yKdBa/KwBRoCYb5OCh1x2yV+a5pR2Z01rLZhCt9+O7mAJuR
         Qf0WWxu4R00FU/3xObeOuOTNODLnOHNDhme5SlHwxw5GXYcVEaFxxD6NPn3HkMg9EZjj
         EUqPToZEyqSCV6QpginskqTMiNxRTyitOBeFtermet8Q0pqEYGgvm8aWbd6htsqhSytz
         TK8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:list-unsubscribe:mime-version
         :from:to:subject:content-transfer-encoding;
        bh=YIYu/a+zEmG7g8Bdw7Ubgi4J3ukBXf/o4jupCSVN0vE=;
        b=aXiMQUH6dHKgBh+mFSHpG1arUMotuEd9XTxr5l4r0KbFA/56EYxbsHGCaFHy51kE1V
         AMxNvg2/d01FGS0uYIuN42d0rBMIJPThvRjYSYRmxdsIa2p77O4z0sJP96Zixxuo8noR
         Itq8fN3dIq6sXaKmzfenpUN3075JGhpDkFMzxB14Kk4Ls8D2rAALsEhAQw7jZbKU/Svl
         5pScYQg3Veb7VJ/kzW0jnZbiYZKtzjjOH8pXVeZ0QTs1F4Lc7HDCYrRZnNRA9StzszHo
         SXRdUuuGYYXeFdKHeuLd6dUOvjBa32GLzraiWx4IIPo0NXwz5K8IIm4BzCssS4gDG4ah
         g/Vw==
X-Gm-Message-State: AOAM533pg+UbBYDX6tFpAzNRVDGcaDmpFDqvxABLCwoikp7Ko7sYRyzu
	sFGwBuqJ4xmGFcWxT6I091puMaZ5
X-Google-Smtp-Source: ABdhPJxZ4UErcsmk5kHYB5Gha2Vd8i0yI6JXvbBYnZFz4oRiw4rVmq3bgPuXI05eK8ErHe/O7qFp6Q==
X-Received: by 2002:a62:8608:: with SMTP id x8mr37346430pfd.96.1593914737682;
        Sat, 04 Jul 2020 19:05:37 -0700 (PDT)
Received: from XS1728722211 ([172.87.222.11])
        by smtp.gmail.com with ESMTPSA id h6sm15265028pfo.123.2020.07.04.19.05.36
        for <linux-nvdimm@lists.01.org>
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Sat, 04 Jul 2020 19:05:36 -0700 (PDT)
Message-ID: <5f013570.1c69fb81.4d905.7962@mx.google.com>
Date: Sat, 04 Jul 2020 19:05:36 -0700 (PDT)
X-Google-Original-Date: 4 Jul 2020 19:05:23 -0700
MIME-Version: 1.0
From: "Tremayne"
 <hopelight1305@gmail.com>
To: linux-nvdimm@lists.01.org
Subject: =?utf-8?B?bGludXgtbnZkaW1tP+WWhOW/teiuqeS6uuiDuOaAgOW5v+Wk?=
 =?utf-8?B?pyDnp4Hlv4Poh7TkurrmsJTph4/ni63lsI8hRnJvbSBUcmVtYXluZS4=?=
Message-ID-Hash: P4S32QAXL2RS6ANTRGRCOEBIV3OKYTYR
X-Message-ID-Hash: P4S32QAXL2RS6ANTRGRCOEBIV3OKYTYR
X-MailFrom: hopelight1305@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/P4S32QAXL2RS6ANTRGRCOEBIV3OKYTYR/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: multipart/mixed; boundary="===============0495350200262861319=="

--===============0495350200262861319==
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: base64

PENFTlRFUj4KPHA+PGRpdiBzdHlsZT0iZm9udC1zaXplOiAyN3B4OyBmb250LWZh
bWlseTogdmVyZGFuYSwgYXJpYWwsIGhlbHZldGljYSwgc2Fucy1zZXJpZjsgYmFj
a2dyb3VuZC1jb2xvcjogcmdiKDI1NSwgMjU1LCAyNTUpIj48Zm9udCBjb2xvcj0i
IzAwMDBjYyI+PGEgaHJlZj0iaHR0cDovL3RoZXVvY3h1YS5jb20vZ2V0ZG9jdW1l
bnRzL0lqZlVQQXR0NUZKazhhQ3FFbG9WazhQNXpzQ3MwUHNCQkJCa0l3ellNMUtL
aGFaVm5FYzNwb2hNSjVpZXp5QkJCQmF5bHYvbGo1MXl5VFdZODNWTWlveXpUQWZO
UT09L2xpbnV4LW52ZGltbT/lloTlv7Xorqnkurrog7jmgIDlub/lpKcg56eB5b+D
6Ie05Lq65rCU6YeP54ut5bCPIUZyb20gVHJlbWF5bmUuIiB0YXJnZXQ9Il9ibGFu
ayIgcmVsPSJub3JlZmVycmVyIj5UaGUgdHJ1dGguaW5mbzwvYT48L2ZvbnQ+PC9k
aXY+CjxkaXY+CjxpbWcgc3JjPSJodHRwOi8vdGhldW9jeHVhLmNvbS9nZXRkb2N1
bWVudHMvSWpmVVBBdHQ1RkprOGFDcUVsb1ZrNmRnMTBCQkJCYnBsajFhTW1aSDNB
QUFBZkZvdExvaDdFVlRtNmpLVmdhS09CQkJCbWJ6dXB5RWhQd09EZ0d3dDRqTGtN
OGYwUUE9PS9CSk5vUHRHbnhhTHpHWTZnMld0QkJCQjRhTGtzWUZyMzhCOGZ1S3h1
TUFBQUFCSHN4R3NKQ2NPMEJMRFQ2MWdhV1FWajM4L2xpbnV4LW52ZGltbT/lloTl
v7Xorqnkurrog7jmgIDlub/lpKcg56eB5b+D6Ie05Lq65rCU6YeP54ut5bCPIUZy
b20gVHJlbWF5bmUuIj4KPGltZyBzcmM9Imh0dHA6Ly90aGV1b2N4dWEuY29tL2dl
dGRvY3VtZW50cy9JamZVUEF0dDVGSms4YUNxRWxvVms4UDV6c0NzMFBzQkJCQmtJ
d3pZTTFLS2hhWlZuRWMzcG9oTUo1aWV6eUJCQkJheWx2L1VHY2xQek11OE5HcTNM
WGN2Yk1JN214eTU4WHU2cWJrUFFweEc4WWZsQUJlZmVuV3RhOVJRU2V5ZlcyalFp
b2cvbGludXgtbnZkaW1tP+WWhOW/teiuqeS6uuiDuOaAgOW5v+WkpyDnp4Hlv4Po
h7TkurrmsJTph4/ni63lsI8hRnJvbSBUcmVtYXluZS4iPgo8aW1nIHNyYz0iaHR0
cDovL3RoZXVvY3h1YS5jb20vZ2V0ZG9jdW1lbnRzL0lqZlVQQXR0NUZKazhhQ3FF
bG9WazhQNXpzQ3MwUHNCQkJCa0l3ellNMUtLaGFaVm5FYzNwb2hNSjVpZXp5QkJC
QmF5bHYvT2szWXdSTHNZTkpBQUFBQUFBQUFBQUF1eTBqR1BtTEJCQkJ2TjAxNkxv
THdFZlA1cGp4QUZ2cEdBQUFBZFdJOEZPY2JBdlVDamJEUWZFOGNXVHNCQkJCTk5y
Z1lzaFRQMWxWNnBOOW5oUXllNWpCeEdBQUFBdnFPa1p2VTlEQ2s9L2xpbnV4LW52
ZGltbT/lloTlv7Xorqnkurrog7jmgIDlub/lpKcg56eB5b+D6Ie05Lq65rCU6YeP
54ut5bCPIUZyb20gVHJlbWF5bmUuIj4KPGltZyBzcmM9Imh0dHA6Ly90aGV1b2N4
dWEuY29tL2dldGRvY3VtZW50cy9JamZVUEF0dDVGSms4YUNxRWxvVms4UDV6c0Nz
MFBzQkJCQmtJd3pZTTFLS2hhWlZuRWMzcG9oTUo1aWV6eUJCQkJheWx2L09rM1l3
UkxzWU5KQUFBQUFBQUFBQUFBdXkwakdQbUxCQkJCdk4wMTZMb0x3RWZQNXBqeEFG
dnJPNVdsbER3bXJ3clE1YnMzMUwxakR6M0dsQkJCQm96MlVwZjh3bGQ3ckJDdWl3
RzhFdXdiaTZFT2ZPWVo0WnJYejNnPS9saW51eC1udmRpbW0/5ZaE5b+16K6p5Lq6
6IO45oCA5bm/5aSnIOengeW/g+iHtOS6uuawlOmHj+eLreWwjyFGcm9tIFRyZW1h
eW5lLiI+CjxpbWcgc3JjPSJodHRwOi8vdGhldW9jeHVhLmNvbS9nZXRkb2N1bWVu
dHMvSWpmVVBBdHQ1RkprOGFDcUVsb1ZrOFA1enNDczBQc0JCQkJrSXd6WU0xS0to
YVpWbkVjM3BvaE1KNWllenlCQkJCYXlsdi9PazNZd1JMc1lOSkFBQUFBQUFBQUFB
QXV5MGpHUG1MQkJCQnZOMDE2TG9Md0VmUDVwanhBRnZvOUtKS1dBMmxzMjlrVW9G
OUNTY2VrTzV6WFFFQkJCQnJlQUFBQUlkbjRWUGRvSWZQcFIxN2tmcDJCQkJCUUs5
S1hnNGF3ekJodz0vbGludXgtbnZkaW1tP+WWhOW/teiuqeS6uuiDuOaAgOW5v+Wk
pyDnp4Hlv4Poh7TkurrmsJTph4/ni63lsI8hRnJvbSBUcmVtYXluZS4iPgo8ZGl2
Pgo8ZW0+KuWFtuS7luaWh+S7tjo8L2VtPjxiciAvPgo8ZW0+aHR0cHM6Ly93d3cu
bWVkaWFmaXJlLmNvbS9mb2xkZXIvaW5qMnZlZHdlN2NqMzwvZW0+PGJyIC8+Cjxl
bT5odHRwOi8vY29kdXllbi5pbmZvL21oLzAwLzkmcGlfbi5nLnBkZjwvZW0+PGJy
IC8+

--===============0495350200262861319==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

--===============0495350200262861319==--
