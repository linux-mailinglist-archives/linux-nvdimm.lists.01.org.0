Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CF97356926
	for <lists+linux-nvdimm@lfdr.de>; Wed,  7 Apr 2021 12:14:49 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 7F150100EBBCE;
	Wed,  7 Apr 2021 03:14:47 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.158.5; helo=mx0a-001b2d01.pphosted.com; envelope-from=riteshh@linux.ibm.com; receiver=<UNKNOWN> 
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 344B2100EBBC4
	for <linux-nvdimm@lists.01.org>; Wed,  7 Apr 2021 03:14:44 -0700 (PDT)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 137A3b4f058603;
	Wed, 7 Apr 2021 06:14:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=qyvICg5bOR724dHN0jiYk0GhBKxcKHxFxhx+efkfdP0=;
 b=gm4eY4fO8pB91ulNkCctgOVnU/mtR5c4og1a5cvGrhbR1Cm9pHAedvD8d1FO5zA9UuT5
 I7J8dz4TYgOsqFxxQ1rIRCmGXYi5okj9JLNMXs1O7P0Sr4hl6V1KB/q+X0Xfk/U60jEq
 12rvuECWUyveozwWKcGxHM7aT5NmcqJVkVz+0okjBzXibYd17x9dGVcXPJY+HXkqCpOP
 fNTz7RBbQf0qV0mKT/GH1Zk/CO9dTOkiMGyytP27gNriFohtzwFjEcdf5fS3cKmjocfr
 m/t6lREXynRZUWlsZtr/+PyDg7LrnLen0c3ar+9j9sr363qZvKTOPAjCduJp3hw+0mXS tQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0b-001b2d01.pphosted.com with ESMTP id 37rw07bttq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 07 Apr 2021 06:14:24 -0400
Received: from m0098413.ppops.net (m0098413.ppops.net [127.0.0.1])
	by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 137A3wjB060848;
	Wed, 7 Apr 2021 06:14:23 -0400
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
	by mx0b-001b2d01.pphosted.com with ESMTP id 37rw07btt0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 07 Apr 2021 06:14:23 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
	by ppma06ams.nl.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 137A3BvM010573;
	Wed, 7 Apr 2021 10:14:21 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
	by ppma06ams.nl.ibm.com with ESMTP id 37rvbw8knx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 07 Apr 2021 10:14:21 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
	by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 137AEJ1o40239448
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 7 Apr 2021 10:14:19 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2B1014C04A;
	Wed,  7 Apr 2021 10:14:19 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C7DAF4C044;
	Wed,  7 Apr 2021 10:14:18 +0000 (GMT)
Received: from localhost (unknown [9.85.69.78])
	by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
	Wed,  7 Apr 2021 10:14:18 +0000 (GMT)
Date: Wed, 7 Apr 2021 15:44:17 +0530
From: riteshh <riteshh@linux.ibm.com>
To: Shiyang Ruan <ruansy.fnst@fujitsu.com>
Subject: Re: [PATCH 1/3] fsdax: Factor helpers to simplify dax fault code
Message-ID: <20210407101417.45mu2m35hfduizpn@riteshh-domain>
References: <20210407063207.676753-1-ruansy.fnst@fujitsu.com>
 <20210407063207.676753-2-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210407063207.676753-2-ruansy.fnst@fujitsu.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 5kC7Gni9-yvd5Wl2UkGLEjQYyu3MvqY_
X-Proofpoint-GUID: QQcIOBDcl5-T6SjKoKh9acNasKx7P6Z1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-04-07_07:2021-04-06,2021-04-07 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 lowpriorityscore=0 suspectscore=0 phishscore=0 priorityscore=1501
 bulkscore=0 malwarescore=0 clxscore=1011 impostorscore=0 mlxlogscore=999
 mlxscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104070070
Message-ID-Hash: SFDFDUAGN2ILGUGSE4Z5WIEMER2ZQ7PX
X-Message-ID-Hash: SFDFDUAGN2ILGUGSE4Z5WIEMER2ZQ7PX
X-MailFrom: riteshh@linux.ibm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org, linux-nvdimm@lists.01.org, linux-fsdevel@vger.kernel.org, darrick.wong@oracle.com, willy@infradead.org, jack@suse.cz, viro@zeniv.linux.org.uk, linux-btrfs@vger.kernel.org, david@fromorbit.com, hch@lst.de, rgoldwyn@suse.de, Ritesh Harjani <riteshh@gmail.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/SFDFDUAGN2ILGUGSE4Z5WIEMER2ZQ7PX/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 21/04/07 02:32PM, Shiyang Ruan wrote:
> The dax page fault code is too long and a bit difficult to read. And it
> is hard to understand when we trying to add new features. Some of the
> PTE/PMD codes have similar logic. So, factor them as helper functions to
> simplify the code.
>
> Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Ritesh Harjani <riteshh@gmail.com>

Sorry, but above email address is wrong. Either of below is ok.

Reviewed-by: Ritesh Harjani <riteshh@linux.ibm.com>
OR
Reviewed-by: Ritesh Harjani <ritesh.list@gmail.com>

>
>
> ---
>  fs/dax.c | 152 ++++++++++++++++++++++++++++++-------------------------
>  1 file changed, 84 insertions(+), 68 deletions(-)

_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
