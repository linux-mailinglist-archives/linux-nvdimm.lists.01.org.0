Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C7B85B3F6D
	for <lists+linux-nvdimm@lfdr.de>; Mon, 16 Sep 2019 19:08:58 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 0C1F3202BDC98;
	Mon, 16 Sep 2019 10:08:26 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=156.151.31.85; helo=userp2120.oracle.com;
 envelope-from=martin.petersen@oracle.com; receiver=linux-nvdimm@lists.01.org 
Received: from userp2120.oracle.com (userp2120.oracle.com [156.151.31.85])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 379F021A07094
 for <linux-nvdimm@lists.01.org>; Mon, 16 Sep 2019 10:08:25 -0700 (PDT)
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8GH4P1W001292;
 Mon, 16 Sep 2019 17:08:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2019-08-05;
 bh=+CZoGIQCmtw4Dmg5SfXe3o0NnRs6559XxydCd+jVXQ8=;
 b=rMOFMhClnL2bIb+8Nz8OOxOVySEHQDVF7v5WrTP6O4DOPNid6vSs20yqRmykr5Gz5S6r
 kEQ5I/e5q2a4124rN0SL0FLm7yDDepFxrRU5MeEjRmyTvMjBM3shn8py2/utRNjBM04Q
 QeEE+SNMHy4EAv9/Di9znLR20SBcE56LvHiTeEyHCODmUGR8tEUUVaP0zsRWHlTbV+gu
 Lz9yFjcsQfR1LsSgw1fOIqsIxFKcLEhKZLwHYZdhrW7OkRyqO27JQWpZB9oAS5pFCM04
 X1akAgK9WEOHgAUqMW4IfDbFQBSvsi0g60nm6MJvt/dq09kWrKwqQzSp7DxhKqVSvqTa xg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by userp2120.oracle.com with ESMTP id 2v0ruqgv7h-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 16 Sep 2019 17:08:54 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8GH4QLn087910;
 Mon, 16 Sep 2019 17:08:54 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
 by userp3030.oracle.com with ESMTP id 2v0nb51tta-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 16 Sep 2019 17:08:54 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
 by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x8GH8qL5007286;
 Mon, 16 Sep 2019 17:08:53 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Mon, 16 Sep 2019 10:08:52 -0700
To: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [Ksummit-discuss] [PATCH v2 3/3] libnvdimm,
 MAINTAINERS: Maintainer Entry Profile
From: "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <156821692280.2951081.18036584954940423225.stgit@dwillia2-desk3.amr.corp.intel.com>
 <156821693963.2951081.11214256396118531359.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20190911184332.GL20699@kadam>
 <9132e214-9b57-07dc-7ee2-f6bc52e960c5@kernel.dk>
 <yq1y2yrdg6w.fsf@oracle.com> <20190916070101.GE18977@kadam>
Date: Mon, 16 Sep 2019 13:08:45 -0400
In-Reply-To: <20190916070101.GE18977@kadam> (Dan Carpenter's message of "Mon, 
 16 Sep 2019 10:01:01 +0300")
Message-ID: <yq1blvkb23m.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9382
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1909160169
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9382
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1909160169
X-BeenThere: linux-nvdimm@lists.01.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
List-Unsubscribe: <https://lists.01.org/mailman/options/linux-nvdimm>,
 <mailto:linux-nvdimm-request@lists.01.org?subject=unsubscribe>
List-Archive: <http://lists.01.org/pipermail/linux-nvdimm/>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Subscribe: <https://lists.01.org/mailman/listinfo/linux-nvdimm>,
 <mailto:linux-nvdimm-request@lists.01.org?subject=subscribe>
Cc: Jens Axboe <axboe@kernel.dk>, ksummit-discuss@lists.linuxfoundation.org,
 linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>


Dan,

>> One pet peeve I have is that people are pretty bad at indicating the
>> intended target tree. I often ask for it in private mail but the
>> practice doesn't seem to stick. I spend a ton of time guessing whether a
>> patch is a fix for a new feature in the x+1 queue or a fix for the
>> current release. It is not always obvious.
>
> The Fixes tag doesn't help?

Always.

> Of course, you've never asked me or anyone on kernel-newbies that
> question.  We don't normally know the answer either.  I do always try
> to figure it out for networking, but it's kind of a pain in the butt
> and I mess up surpisingly often for how much effort I put into getting
> it right.

It's not a big issue for your patches. These are inevitably fixes and
I'll pick an appropriate tree depending on where we are in the cycle,
how likely one is to hit the issue, whether the driver is widely used,
etc.

Vendor driver submissions, however, are generally huge. Sometimes 50+
patches per submission window. And during this window I often get on the
order of 10 to 20 patches for the same driver in the fixes tree. It is
not always easy to determine whether a bug fix series is for one tree or
the other.

-- 
Martin K. Petersen	Oracle Linux Engineering
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
