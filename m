Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B2E71B2771
	for <lists+linux-nvdimm@lfdr.de>; Fri, 13 Sep 2019 23:44:49 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 70E7A202EA410;
	Fri, 13 Sep 2019 14:44:39 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=141.146.126.78; helo=aserp2120.oracle.com;
 envelope-from=martin.petersen@oracle.com; receiver=linux-nvdimm@lists.01.org 
Received: from aserp2120.oracle.com (aserp2120.oracle.com [141.146.126.78])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id A923D202EA3F7
 for <linux-nvdimm@lists.01.org>; Fri, 13 Sep 2019 14:44:38 -0700 (PDT)
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8DLhWXb132747;
 Fri, 13 Sep 2019 21:44:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2019-08-05;
 bh=wnF8ywzVvXMffOXwXnD9nBENtpO8KLHMv3TdJiXOPzI=;
 b=MoNr9MbcVeXC3+gsrSAxNWIpe6pUGsKqbjVfu/gzfBk8M/lVVx++UXfntcaHTPUXvTAB
 gxhev4FV4QXjLAOwsNKyxYlXowV/f8pcpBCu88JhOMdCnMAZXEmnZ9xv4ryiIqW+ZAVs
 4xESpto0Ptjpzxno3LQ0fMVsqUH43TWc80eF69GoEHxR2tjtZFlDoQHgKJDIEwzsIkkv
 TY4OZLKZDJVVW1r6cOcXvUHt2UY/utssTsL5JKWL8euVs6nfJUo7Hi9voAJd7rQvOJrZ
 k+QE5U39T9wjxgWNqtDxtUll9Ud48g0tiblhu4P5FEJArABf7xKw9xTp/niweOkw3g2m HA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by aserp2120.oracle.com with ESMTP id 2uytd3771d-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 13 Sep 2019 21:44:44 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8DLhJAL095154;
 Fri, 13 Sep 2019 21:44:43 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
 by userp3020.oracle.com with ESMTP id 2uytdncjqh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 13 Sep 2019 21:44:43 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
 by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x8DLig3u013887;
 Fri, 13 Sep 2019 21:44:42 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Fri, 13 Sep 2019 14:44:41 -0700
To: Jens Axboe <axboe@kernel.dk>
Subject: Re: [Ksummit-discuss] [PATCH v2 3/3] libnvdimm,
 MAINTAINERS: Maintainer Entry Profile
From: "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <156821692280.2951081.18036584954940423225.stgit@dwillia2-desk3.amr.corp.intel.com>
 <156821693963.2951081.11214256396118531359.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20190911184332.GL20699@kadam>
 <9132e214-9b57-07dc-7ee2-f6bc52e960c5@kernel.dk>
Date: Fri, 13 Sep 2019 17:44:39 -0400
In-Reply-To: <9132e214-9b57-07dc-7ee2-f6bc52e960c5@kernel.dk> (Jens Axboe's
 message of "Wed, 11 Sep 2019 16:11:29 -0600")
Message-ID: <yq1y2yrdg6w.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9379
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1909130216
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9379
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1909130216
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
Cc: ksummit-discuss@lists.linuxfoundation.org, linux-nvdimm@lists.01.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 Dan Carpenter <dan.carpenter@oracle.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>


Jens,

> Additionally, it would seem saner to standardize rules around when
> code is expected to hit the maintainers hands for kernel
> releases. Both yours and Martins deals with that, there really
> shouldn't be the need to have this specified in detail per sub-system.

Yeah. There is basically nothing specific about SCSI in my write-up
outside of the branch naming.

I deliberately didn't mention coding style preferences. We have so much
20+ year old cruft in SCSI that's impossible to even entertain. But I do
request new code to follow coding-style.rst. BYOXT.

Also note that the original target audience for my document. It was
aimed at onboarding new driver contributors from hardware companies. So
people that don't live and breathe Linux development and who are not
intimately familiar with the kernel development process. It's possible
that we have this information in Documentation/ these days; I'll go
look. But it didn't exist when this doc was written. And in my
experience nobody coming to Linux development from the outside
understands what the "merge window" is. And when the appropriate time is
to submit patches and features. I think this would be a great area to
have a common set of guidelines and documentation. I'd prefer for this
to be global and then let maintainers apply their own wiggle room
instead of documenting particular rules for a given subsystem.

One pet peeve I have is that people are pretty bad at indicating the
intended target tree. I often ask for it in private mail but the
practice doesn't seem to stick. I spend a ton of time guessing whether a
patch is a fix for a new feature in the x+1 queue or a fix for the
current release. It is not always obvious.

-- 
Martin K. Petersen	Oracle Linux Engineering
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
