Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C55C6180E15
	for <lists+linux-nvdimm@lfdr.de>; Wed, 11 Mar 2020 03:42:34 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 1E54410FC36C7;
	Tue, 10 Mar 2020 19:43:24 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=141.146.126.78; helo=aserp2120.oracle.com; envelope-from=martin.petersen@oracle.com; receiver=<UNKNOWN> 
Received: from aserp2120.oracle.com (aserp2120.oracle.com [141.146.126.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 0965810FC36C5
	for <linux-nvdimm@lists.01.org>; Tue, 10 Mar 2020 19:43:21 -0700 (PDT)
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
	by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02B2gPGM098802;
	Wed, 11 Mar 2020 02:42:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2020-01-29;
 bh=KfOy4Bpiplasnl/ncLcT96S4AGSmRKSa2SGlhHhNj7c=;
 b=Gfm9v9XcT6XQ+dTH+zLoCwiHouQb3XBcrrPjnFoVSULeMvPSTMRT1AYsdS+YZ/h3e+kK
 4LNGmyUcyHVkh6jH/c00tkOF/3GQZoqbPtYA9xyZ0kk+9/uynbRkFq048YYs1v6zp4Zo
 gxGCrvRgFEyVdsrOwOOqZtjVemeQjSMQoFFQbYD9Fd35xBUFK0CCaSdCmrcXf9Qw+7wj
 ZSq2gsUJfmR3KAUOWCRSA+8OJ99ICISH7J7Dej+rFw1v0UebuiUG/XEBfkkAmf9KIrsx
 CGHydj5mEdJ0zddeM4eAfSZduPG7zVsnIu7uMVCEiXH2n2kBXNidp0HUaJJgxcFeLscF Sw==
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
	by aserp2120.oracle.com with ESMTP id 2yp9v641k0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 11 Mar 2020 02:42:24 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
	by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02B2g9Bi007440;
	Wed, 11 Mar 2020 02:42:24 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
	by aserp3030.oracle.com with ESMTP id 2yp8pvmbc7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 11 Mar 2020 02:42:24 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
	by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 02B2gLke024249;
	Wed, 11 Mar 2020 02:42:21 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
	by default (Oracle Beehive Gateway v4.0)
	with ESMTP ; Tue, 10 Mar 2020 19:42:20 -0700
To: Matteo Croce <mcroce@redhat.com>
Subject: Re: [PATCH v3] block: refactor duplicated macros
From: "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20200311002254.121365-1-mcroce@redhat.com>
Date: Tue, 10 Mar 2020 22:42:17 -0400
In-Reply-To: <20200311002254.121365-1-mcroce@redhat.com> (Matteo Croce's
	message of "Wed, 11 Mar 2020 01:22:54 +0100")
Message-ID: <yq1k13rr4s6.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9556 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 mlxlogscore=999 bulkscore=0 suspectscore=0 mlxscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003110015
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9556 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0 mlxscore=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 mlxlogscore=999
 phishscore=0 adultscore=0 clxscore=1011 impostorscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2003110015
Message-ID-Hash: WO7O5ZX3IX5EFA3GWHMK6YF5FNCOYYYX
X-Message-ID-Hash: WO7O5ZX3IX5EFA3GWHMK6YF5FNCOYYYX
X-MailFrom: martin.petersen@oracle.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org, linux-bcache@vger.kernel.org, linux-raid@vger.kernel.org, linux-mmc@vger.kernel.org, xen-devel@lists.xenproject.org, linux-scsi@vger.kernel.org, linux-nfs@vger.kernel.org, Jens Axboe <axboe@kernel.dk>, "James E.J. Bottomley" <jejb@linux.ibm.com>, Ulf Hansson <ulf.hansson@linaro.org>, Anna Schumaker <anna.schumaker@netapp.com>, Song Liu <song@kernel.org>, Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/WO7O5ZX3IX5EFA3GWHMK6YF5FNCOYYYX/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit


Matteo,

> The macros PAGE_SECTORS, PAGE_SECTORS_SHIFT and SECTOR_MASK are
> defined several times in different flavours across the whole tree.
> Define them just once in a common header.
>
> While at it, replace replace "PAGE_SHIFT - 9" with
> "PAGE_SECTORS_SHIFT" too and rename SECTOR_MASK to PAGE_SECTORS_MASK.

Looks OK to me.

Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>

-- 
Martin K. Petersen	Oracle Linux Engineering
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
