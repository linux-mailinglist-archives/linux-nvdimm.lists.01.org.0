Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 77841C3FAE
	for <lists+linux-nvdimm@lfdr.de>; Tue,  1 Oct 2019 20:18:13 +0200 (CEST)
Received: from new-ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 046A110FC71F6;
	Tue,  1 Oct 2019 11:19:39 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=141.146.126.78; helo=aserp2120.oracle.com; envelope-from=martin.petersen@oracle.com; receiver=<UNKNOWN> 
Received: from aserp2120.oracle.com (aserp2120.oracle.com [141.146.126.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 2787E10FC71F3
	for <linux-nvdimm@lists.01.org>; Tue,  1 Oct 2019 11:19:36 -0700 (PDT)
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
	by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x91IDC6I090361;
	Tue, 1 Oct 2019 18:17:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2019-08-05;
 bh=wq9wrgNUITTrwjzKGMvvggax4gHnlKlrBnSxXFjscBc=;
 b=WRt6b4jK4tblC9ReI2WzrIthKeVlpi8iJwvLXInQ1AYW2AHlgT5SbD/pn/C/fwBRyQtl
 HpQgbfYX+Fz3e1PQ6Kb6WDnXsDabD5nPsj7J8wBd0441MBllnoNcGFZY4A55qGs4bY2o
 1ue6yg+Ucs4gAD/0ohwViaryUrUKa9TDT1axhJSUcrfqa+JJU8S5wDxEQVjRmyLAG8iU
 pRBPBrslzJW/gnLzSmvrkLpkLALi4tnu27RyCekoFrN1dByfhHc8fjU0ntliufe4WbjO
 BmMI5it+w+KwyhMqMyoOsxuqiPp9eqEPNrNiOjzjlpI+vKrpAN352CG+MBn96ove1qni mw==
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
	by aserp2120.oracle.com with ESMTP id 2v9yfq7xv5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 01 Oct 2019 18:17:53 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
	by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x91I8H3l079821;
	Tue, 1 Oct 2019 18:17:52 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
	by aserp3020.oracle.com with ESMTP id 2vbqd1a86x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 01 Oct 2019 18:17:52 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
	by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x91IHhs8012803;
	Tue, 1 Oct 2019 18:17:43 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
	by default (Oracle Beehive Gateway v4.0)
	with ESMTP ; Tue, 01 Oct 2019 11:17:43 -0700
To: Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH v2 2/3] Maintainer Handbook: Maintainer Entry Profile
From: "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <156821692280.2951081.18036584954940423225.stgit@dwillia2-desk3.amr.corp.intel.com>
	<156821693396.2951081.7340292149329436920.stgit@dwillia2-desk3.amr.corp.intel.com>
	<20191001075559.629eb059@lwn.net>
Date: Tue, 01 Oct 2019 14:17:39 -0400
In-Reply-To: <20191001075559.629eb059@lwn.net> (Jonathan Corbet's message of
	"Tue, 1 Oct 2019 07:55:59 -0600")
Message-ID: <yq1y2y4tjng.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9397 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=866
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910010147
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9397 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=943 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910010147
Message-ID-Hash: XVZHWBIQU3CIQGIRNSHI566VGDAKFGC2
X-Message-ID-Hash: XVZHWBIQU3CIQGIRNSHI566VGDAKFGC2
X-MailFrom: martin.petersen@oracle.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Mauro Carvalho Chehab <mchehab@kernel.org>, Steve French <stfrench@microsoft.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, "Tobin C. Harding" <me@tobin.cc>, Olof Johansson <olof@lixom.net>, Daniel Vetter <daniel.vetter@ffwll.ch>, Joe Perches <joe@perches.com>, Dmitry Vyukov <dvyukov@google.com>, Alexandre Belloni <alexandre.belloni@bootlin.com>, linux-nvdimm@lists.01.org, ksummit-discuss@lists.linuxfoundation.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/XVZHWBIQU3CIQGIRNSHI566VGDAKFGC2/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit


Jonathan,

> Thus far, the maintainer guide is focused on how to *be* a maintainer.
> This document, instead, is more about how to deal with specific
> maintainers.  So I suspect that Documentation/maintainer might be the
> wrong place for it.
>
> Should we maybe place it instead under Documentation/process, or even
> create a new top-level "book" for this information?

I think Documentation/process is the right place for all the common
practices and guidelines for code submission. Documentation is already
pretty big. And based on the discussions in this thread, I think we're
better off enhancing the existing process documents instead of
introducing more places for people to look.

-- 
Martin K. Petersen	Oracle Linux Engineering
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
