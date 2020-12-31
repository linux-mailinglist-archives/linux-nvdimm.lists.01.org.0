Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C17C2E7F9E
	for <lists+linux-nvdimm@lfdr.de>; Thu, 31 Dec 2020 12:20:06 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 40EDA100EC1E9;
	Thu, 31 Dec 2020 03:20:04 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::432; helo=mail-pf1-x432.google.com; envelope-from=sontruong2646@gmail.com; receiver=<UNKNOWN> 
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id CCC30100EC1E3
	for <linux-nvdimm@lists.01.org>; Thu, 31 Dec 2020 03:20:01 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id h10so10178722pfo.9
        for <linux-nvdimm@lists.01.org>; Thu, 31 Dec 2020 03:20:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:list-unsubscribe:mime-version:from:to:subject
         :content-transfer-encoding;
        bh=QuExysRG3ftD18/9EiaCFO/sg8aygLM02mX6IAAtDTY=;
        b=PJZ+FtLIUY8thBPu630xcO4e+1GEGQu6Yklk+EkttrLb96Iw5bQgrPscnT7alRBhDw
         pr+DisUyrajp2LUl39Z1mJN2iUfYQeUucwODDnC9P9CKegjjK0hp/U0RqqcJRagO0UUG
         l+eS35TzfMi2e5FKfydDb8EXzTer+Zuk0XY2k1kPdwXKde2VZYWiQ9uzZzjD6ejHtBow
         otEHGIsLIQfmYIpUzNveLIQvt5a7DzAWcaEgxcaPXNXOTLxPZ01GfNBveID9f3Ne0tTW
         VzE+szdnve9rh52JoQW3ZkSzbdgjywU/Y+z17TsUeS3B/WNEZpZV7SAwu7Q16s48Q+ET
         3L7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:list-unsubscribe:mime-version
         :from:to:subject:content-transfer-encoding;
        bh=QuExysRG3ftD18/9EiaCFO/sg8aygLM02mX6IAAtDTY=;
        b=tVrRwMyRnzDW2v7aArgFRenthq/bMTwiCHDGySGB1PD6uEcmKZ636XmstjAL7g4arE
         8MGCYnWLXsxKigb3VOmB4Y+WQ0bct3QZgXPFOAkXE1F4Wq8U6kLwJElWrZ7xtXdGdpVJ
         MWjFtvzTdb+P/1NUEQIHP6IEam2MN7MuLZEAr5tvwK0/oDYikPCkdgNuZ9vrvQyCFQRE
         ZztgPifDkVWI2Jpycx1Vx3GEgL3s445wAsdXEfbdvNyPWKOEj72ZGXEamydj47WI5E7k
         eHm2XRB1mYgSvRnE48L6hF/0NV/skeB1tKyUvI2s/yzPjVWcAJNKFCEkZy3znPHS2TCK
         7Y3A==
X-Gm-Message-State: AOAM5310CJnad3LBYwwfEZjMs0fyYw89MCvog+Oxe8aHzBK1rdPHs6gf
	O3cn0zRwsUNr/ErYb489c59jpyNaL/w=
X-Google-Smtp-Source: ABdhPJwh09jByL6ODRu9bUJqNd3bPzvKqT3KKu/beXsO7Mh+NOPeHE6Rtr9rORFz/sytZq23Y2eWRA==
X-Received: by 2002:a65:5209:: with SMTP id o9mr13652905pgp.34.1609413600965;
        Thu, 31 Dec 2020 03:20:00 -0800 (PST)
Received: from DESKTOP-DI4367S ([27.3.184.35])
        by smtp.gmail.com with ESMTPSA id a12sm48288103pgq.5.2020.12.31.03.19.59
        for <linux-nvdimm@lists.01.org>
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Thu, 31 Dec 2020 03:20:00 -0800 (PST)
Message-ID: <5fedb3e0.1c69fb81.3e4df.cb89@mx.google.com>
Date: Thu, 31 Dec 2020 03:20:00 -0800 (PST)
X-Google-Original-Date: 31 Dec 2020 18:19:58 +0700
MIME-Version: 1.0
From: "Anne" <sontruong2646@gmail.com>
To: linux-nvdimm@lists.01.org
Subject: =?utf-8?B?bGludXgtbnZkaW1tP+WmkuWrieeahOaBtuaenCFGcm9tIEFu?=
 =?utf-8?B?bmUu?=
Message-ID-Hash: V4ARLG2OP5THLSHEOGGS2ZMBG7FJ5AWA
X-Message-ID-Hash: V4ARLG2OP5THLSHEOGGS2ZMBG7FJ5AWA
X-MailFrom: sontruong2646@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/V4ARLG2OP5THLSHEOGGS2ZMBG7FJ5AWA/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: multipart/mixed; boundary="===============5327664920958090276=="

--===============5327664920958090276==
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: base64

PENFTlRFUj4KPHA+PGRpdiBzdHlsZT0iZm9udC1zaXplOiAyN3B4OyBmb250LWZhbWls
eTogdmVyZGFuYSwgYXJpYWwsIGhlbHZldGljYSwgc2Fucy1zZXJpZjsgYmFja2dyb3Vu
ZC1jb2xvcjogcmdiKDI1NSwgMjU1LCAyNTUpIj48Zm9udCBjb2xvcj0iIzAwMDBjYyI+
PGEgaHJlZj0iaHR0cDovL3RoZXVvY3h1YS5jb20vZ2V0ZG9jdW1lbnRzL0lqZlVQQXR0
NUZKazhhQ3FFbG9WazJ6WVJENHY2NDZzUEtoaGcyRUJCQkIyYUlCQkJCRG5zaVVFQ1Ix
RFpmVGd3T0ttZ3ovdmcxOFZoNHNacldWbVpmd1ZzSEtZQT09L2xpbnV4LW52ZGltbT/l
ppLlq4nnmoTmgbbmnpwhRnJvbSBBbm5lLiIgdGFyZ2V0PSJfYmxhbmsiIHJlbD0ibm9y
ZWZlcnJlciI+VGhlIHRydXRoLmluZm88L2E+PC9mb250PjwvZGl2Pgo8ZGl2Pgo8aW1n
IHNyYz0iaHR0cDovL3RoZXVvY3h1YS5jb20vZ2V0ZG9jdW1lbnRzL0lqZlVQQXR0NUZK
azhhQ3FFbG9WazRDdUZPYldNcGkxcm42UnJBTWdnUmdyMHV1eDlFRXdlVHNUMG5BNFha
ZWJ5T1FBQUFBNHdlMUVLQkJCQjVMNGFsZnlUN3pscHNab3lKSVFMVklPY2VzRkdnMVVr
PS9CSk5vUHRHbnhhTHpHWTZnMld0QkJCQjRhTGtzWUZyMzhCOGZ1S3h1TUFBQUFCSHN4
R3NKQ2NPMEJMRFQ2MWdhV1FWajM4L2xpbnV4LW52ZGltbT/lppLlq4nnmoTmgbbmnpwh
RnJvbSBBbm5lLiI+CjxpbWcgc3JjPSJodHRwOi8vdGhldW9jeHVhLmNvbS9nZXRkb2N1
bWVudHMvSWpmVVBBdHQ1RkprOGFDcUVsb1ZrMnpZUkQ0djY0NnNQS2hoZzJFQkJCQjJh
SUJCQkJEbnNpVUVDUjFEWmZUZ3dPS21nei9UNnl3M1JIaFVLWFBTYUFBQUE0bWtlUTJZ
RXhjQUFBQXVXb3Z3bFdtNXdYWktzV1ZoTERzUXd3cURLZ3dwck1lbm41OFZ4L2xpbnV4
LW52ZGltbT/lppLlq4nnmoTmgbbmnpwhRnJvbSBBbm5lLiI+CjxpbWcgc3JjPSJodHRw
Oi8vdGhldW9jeHVhLmNvbS9nZXRkb2N1bWVudHMvSWpmVVBBdHQ1RkprOGFDcUVsb1Zr
MnpZUkQ0djY0NnNQS2hoZzJFQkJCQjJhSUJCQkJEbnNpVUVDUjFEWmZUZ3dPS21nei8w
ZmlLb1lLcWljQ3hmcVVXMDZDWjNOMk9GaEVrUEcwWUllQWdOQUFBQVFucFJ3RlVMTk1r
OTB2QUZEYjlBYTVSNHVzZG5QVEdLSUppc1N3SUttSFU0OHVhRGw4MXRacUpNZHdvMUl0
YzNpT1E4Zz0vbGludXgtbnZkaW1tP+WmkuWrieeahOaBtuaenCFGcm9tIEFubmUuIj4K
PGltZyBzcmM9Imh0dHA6Ly90aGV1b2N4dWEuY29tL2dldGRvY3VtZW50cy9JamZVUEF0
dDVGSms4YUNxRWxvVmsyellSRDR2NjQ2c1BLaGhnMkVCQkJCMmFJQkJCQkRuc2lVRUNS
MURaZlRnd09LbWd6LzBmaUtvWUtxaWNDeGZxVVcwNkNaM04yT0ZoRWtQRzBZSWVBZ05B
QUFBUW5wUngzSXhOZEVUdWpiSDFmWEJCQkI1NUJCQkJvcVZjUGZtOFFBQUFBQWFQYzZP
cnMzUzdoZUgydHJDZWtVWEFjUHhOYmVWckJYQThzPS9saW51eC1udmRpbW0/5aaS5auJ
55qE5oG25p6cIUZyb20gQW5uZS4iPgo8aW1nIHNyYz0iaHR0cDovL3RoZXVvY3h1YS5j
b20vZ2V0ZG9jdW1lbnRzL0lqZlVQQXR0NUZKazhhQ3FFbG9WazJ6WVJENHY2NDZzUEto
aGcyRUJCQkIyYUlCQkJCRG5zaVVFQ1IxRFpmVGd3T0ttZ3ovMGZpS29ZS3FpY0N4ZnFV
VzA2Q1ozTjJPRmhFa1BHMFlJZUFnTkFBQUFRbnBSeEFBQUFrb2N1Zk05cmZkTm90OWRG
QmtmUUYwMm1uVmlvR0x2S0JCQkJsQ1B0cjFuOFlWNjM0TVI1TWUxSUQzQURXQjFaQU09
L2xpbnV4LW52ZGltbT/lppLlq4nnmoTmgbbmnpwhRnJvbSBBbm5lLiI+CjxkaXY+Cjxl
bT4q5YW25LuW5paH5Lu2OjwvZW0+PGJyIC8+CjxlbT5odHRwczovL3d3dy5tZWRpYWZp
cmUuY29tL2ZvbGRlci9pbmoydmVkd2U3Y2ozPC9lbT48YnIgLz4KPGVtPmh0dHA6Ly9j
b2R1eWVuLmluZm8vbWgvMDAvOSZwaV9uLmcucGRmPC9lbT48YnIgLz4=

--===============5327664920958090276==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

--===============5327664920958090276==--
