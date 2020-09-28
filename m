Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DBBD27AEE9
	for <lists+linux-nvdimm@lfdr.de>; Mon, 28 Sep 2020 15:15:14 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 3FA5D1509C07A;
	Mon, 28 Sep 2020 06:15:12 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=vaibhav@linux.ibm.com; receiver=<UNKNOWN> 
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 52FE31509C079
	for <linux-nvdimm@lists.01.org>; Mon, 28 Sep 2020 06:15:09 -0700 (PDT)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08SD1tpm165959;
	Mon, 28 Sep 2020 09:15:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : in-reply-to : references : date : message-id : mime-version :
 content-type; s=pp1; bh=bc+PZdnmwDaY+qg5gm8ZyGfTSYe0zIvR7oRiYTPQu2c=;
 b=slaYfrxXRVj28DX0/TdwvrWSF6imYUPec9dIFygFF9frRlD0Zd/cGOH14fqDLPC0wAIp
 6by21wqsByylSt9aYhcoyAPK9Dgy6SFW0k6SANgnwqnoWKcPH715e74FzV/U6kpV4tKF
 iA0rUO+Q+2aKHcahtYYeoYzAHnSHjbhWdAGN1lSjSDBg8LPQFD70yzDKLm9CIXGzphW2
 fA7QLc58wkXbUdu/o2A2FgIHZ6VBWvCvazYDJxEU/izMAKE+/CXOUa5smff9KYBrqdW0
 ucclraWh4abVlh+uU9mmifYaHDxF/bC1Kq7xyDXduVZMUI/PD2rp18Qbbz7WOwoIUHK2 4w==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com with ESMTP id 33ufvy1j4f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 28 Sep 2020 09:15:01 -0400
Received: from m0098394.ppops.net (m0098394.ppops.net [127.0.0.1])
	by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 08SD1tJs166016;
	Mon, 28 Sep 2020 09:15:01 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
	by mx0a-001b2d01.pphosted.com with ESMTP id 33ufvy1j37-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 28 Sep 2020 09:15:00 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
	by ppma04ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 08SDCjfS006080;
	Mon, 28 Sep 2020 13:14:58 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
	by ppma04ams.nl.ibm.com with ESMTP id 33sw97t5we-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 28 Sep 2020 13:14:58 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
	by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 08SDEuiU33423642
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 28 Sep 2020 13:14:56 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6747752051;
	Mon, 28 Sep 2020 13:14:56 +0000 (GMT)
Received: from vajain21.in.ibm.com (unknown [9.85.68.227])
	by d06av21.portsmouth.uk.ibm.com (Postfix) with SMTP id 36C4B52050;
	Mon, 28 Sep 2020 13:14:53 +0000 (GMT)
Received: by vajain21.in.ibm.com (sSMTP sendmail emulation); Mon, 28 Sep 2020 18:44:52 +0530
From: Vaibhav Jain <vaibhav@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, linux-nvdimm@lists.01.org
Subject: Re: [PATCH] powerpc/papr_scm: Add PAPR command family to
 pass-through command-set
In-Reply-To: <20200913211904.24472-1-vaibhav@linux.ibm.com>
References: <20200913211904.24472-1-vaibhav@linux.ibm.com>
Date: Mon, 28 Sep 2020 18:44:52 +0530
Message-ID: <87pn662gc3.fsf@vajain21.in.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-28_11:2020-09-28,2020-09-28 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 impostorscore=0
 mlxscore=0 lowpriorityscore=0 clxscore=1011 adultscore=0 spamscore=0
 bulkscore=0 mlxlogscore=999 malwarescore=0 priorityscore=1501
 suspectscore=1 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009280102
Message-ID-Hash: V7X4GXCCAGFQMFGWRHLE2W23BSDQBQFI
X-Message-ID-Hash: V7X4GXCCAGFQMFGWRHLE2W23BSDQBQFI
X-MailFrom: vaibhav@linux.ibm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/V7X4GXCCAGFQMFGWRHLE2W23BSDQBQFI/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Dan, Ira and Vishal,

Can you please take a look at this patch. Without it the functionality
to report nvdimm health via ndctl breaks on 5.9

Thanks,
~ Vaibhav

Vaibhav Jain <vaibhav@linux.ibm.com> writes:

> Add NVDIMM_FAMILY_PAPR to the list of valid 'dimm_family_mask'
> acceptable by papr_scm. This is needed as since commit
> 92fe2aa859f5 ("libnvdimm: Validate command family indices") libnvdimm
> performs a validation of 'nd_cmd_pkg.nd_family' received as part of
> ND_CMD_CALL processing to ensure only known command families can use
> the general ND_CMD_CALL pass-through functionality.
>
> Without this change the ND_CMD_CALL pass-through targeting
> NVDIMM_FAMILY_PAPR error out with -EINVAL.
>
> Fixes: 92fe2aa859f5 ("libnvdimm: Validate command family indices")
> Signed-off-by: Vaibhav Jain <vaibhav@linux.ibm.com>
> ---
>  arch/powerpc/platforms/pseries/papr_scm.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/arch/powerpc/platforms/pseries/papr_scm.c b/arch/powerpc/platforms/pseries/papr_scm.c
> index 5493bc847bd08..27268370dee00 100644
> --- a/arch/powerpc/platforms/pseries/papr_scm.c
> +++ b/arch/powerpc/platforms/pseries/papr_scm.c
> @@ -898,6 +898,9 @@ static int papr_scm_nvdimm_init(struct papr_scm_priv *p)
>  	p->bus_desc.of_node = p->pdev->dev.of_node;
>  	p->bus_desc.provider_name = kstrdup(p->pdev->name, GFP_KERNEL);
>  
> +	/* Set the dimm command family mask to accept PDSMs */
> +	set_bit(NVDIMM_FAMILY_PAPR, &p->bus_desc.dimm_family_mask);
> +
>  	if (!p->bus_desc.provider_name)
>  		return -ENOMEM;
>  
> -- 
> 2.26.2
>
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
