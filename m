Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BE3E2AB083
	for <lists+linux-nvdimm@lfdr.de>; Mon,  9 Nov 2020 06:11:41 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 27F661655E743;
	Sun,  8 Nov 2020 21:11:39 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.158.5; helo=mx0a-001b2d01.pphosted.com; envelope-from=aneesh.kumar@linux.ibm.com; receiver=<UNKNOWN> 
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 9C8A3126B9EC5
	for <linux-nvdimm@lists.01.org>; Sun,  8 Nov 2020 21:11:36 -0800 (PST)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0A952ivd085854;
	Mon, 9 Nov 2020 00:11:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : subject :
 in-reply-to : references : date : message-id : mime-version :
 content-type; s=pp1; bh=kzoeUaRh5qTlNi+1v8LN2aJJ4yikTIhk0X0bUquyiz0=;
 b=Eys054xbORaPJfFRM0aueeh6uG0m3LqYDXJ4RTpo9MeY4TDFtSSidHJQ/6n3JzNadZ5i
 NUBLf5zHMer8lUg2RSC4H9i/FhSV6ZGM9K8bCS91dMfPQkrwEX6twa2J00PkedbU0BPU
 zPeVE1AK26VlIzCLWSoJyoZQ+hRia+r+4VYJoK24sF7uMHoapsAVnVIRxeFM5iQQ2bFI
 r+7aeguICXz9uJX0JYNQ67nwAPb4gwo/vQXVnTYGCbxRF2+xjojow0dvZ1F8Sw4L2x3V
 051YAjRXK2nz/kmMbfsqq1fztHDXnTRPrgWgqEg+huKnrCneBluOBL4r3KDJKh8TfHAx jA==
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com [169.47.144.26])
	by mx0b-001b2d01.pphosted.com with ESMTP id 34p9d85npt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Nov 2020 00:11:33 -0500
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
	by ppma04wdc.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0A957wr2025042;
	Mon, 9 Nov 2020 05:11:33 GMT
Received: from b03cxnp08028.gho.boulder.ibm.com (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
	by ppma04wdc.us.ibm.com with ESMTP id 34nk79ct2v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Nov 2020 05:11:33 +0000
Received: from b03ledav003.gho.boulder.ibm.com (b03ledav003.gho.boulder.ibm.com [9.17.130.234])
	by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0A95BWul16581260
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 9 Nov 2020 05:11:32 GMT
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0DF566A05A;
	Mon,  9 Nov 2020 05:11:32 +0000 (GMT)
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9EA2F6A04D;
	Mon,  9 Nov 2020 05:11:30 +0000 (GMT)
Received: from skywalker.linux.ibm.com (unknown [9.79.222.119])
	by b03ledav003.gho.boulder.ibm.com (Postfix) with ESMTP;
	Mon,  9 Nov 2020 05:11:30 +0000 (GMT)
X-Mailer: emacs 28.0.50 (via feedmail 11-beta-1 I)
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To: linux-nvdimm@lists.01.org, dan.j.williams@intel.com,
        vishal.l.verma@intel.com
Subject: Re: [PATCH] daxctl: phys_index value 0 is valid
In-Reply-To: <20201020052704.331557-1-aneesh.kumar@linux.ibm.com>
References: <20201020052704.331557-1-aneesh.kumar@linux.ibm.com>
Date: Mon, 09 Nov 2020 10:41:27 +0530
Message-ID: <87v9efp11c.fsf@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-09_01:2020-11-05,2020-11-09 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 clxscore=1015 mlxlogscore=999 priorityscore=1501 lowpriorityscore=0
 malwarescore=0 bulkscore=0 adultscore=0 phishscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011090026
Message-ID-Hash: VC5MQO6PU5NQ2J5MNOGD2MBZXLBFSOWH
X-Message-ID-Hash: VC5MQO6PU5NQ2J5MNOGD2MBZXLBFSOWH
X-MailFrom: aneesh.kumar@linux.ibm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/VC5MQO6PU5NQ2J5MNOGD2MBZXLBFSOWH/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit


Hi All,

"Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com> writes:

> On power platforms we can find
>  # cat /sys/devices/system/memory/memory0/phys_index
> 00000000
>
> This results in
>
> libdaxctl: memblock_in_dev: dax1.0: memory0: Unable to determine phys_index: Success
>
> Avoid considering phys_index == 0 as error.


 A gentle ping for this patch. Will appreciate a feedback on this

>
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
> ---
>  daxctl/lib/libdaxctl.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/daxctl/lib/libdaxctl.c b/daxctl/lib/libdaxctl.c
> index ee4a069eb463..3cb89c755978 100644
> --- a/daxctl/lib/libdaxctl.c
> +++ b/daxctl/lib/libdaxctl.c
> @@ -1229,7 +1229,7 @@ static int memblock_in_dev(struct daxctl_memory *mem, const char *memblock)
>  	rc = sysfs_read_attr(ctx, path, buf);
>  	if (rc == 0) {
>  		phys_index = strtoul(buf, NULL, 16);
> -		if (phys_index == 0 || phys_index == ULONG_MAX) {
> +		if (phys_index == ULONG_MAX) {
>  			rc = -errno;
>  			err(ctx, "%s: %s: Unable to determine phys_index: %s\n",
>  				devname, memblock, strerror(-rc));
> -- 
> 2.26.2
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
