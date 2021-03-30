Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E44C34E084
	for <lists+linux-nvdimm@lfdr.de>; Tue, 30 Mar 2021 07:03:33 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id C8282100EBB96;
	Mon, 29 Mar 2021 22:03:31 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=aneesh.kumar@linux.ibm.com; receiver=<UNKNOWN> 
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id ED552100EC1D3
	for <linux-nvdimm@lists.01.org>; Mon, 29 Mar 2021 22:03:29 -0700 (PDT)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 12U4Xn8e040438;
	Tue, 30 Mar 2021 01:03:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : in-reply-to : references : date : message-id : mime-version :
 content-type; s=pp1; bh=MkRFTZ+yQ4oZTVfxLM4HDI9YIxINp2dFxT8AxBvUW8s=;
 b=kBPxEfcuxNPhvJSsQiVvdEvxHBp5WE9qw2CvHu7FVzPKjPsvthKN3kNBjuAz0q51xIne
 uULawPmXn1hu/O6Q505F3BPn536kZL1u34/YJ08llk5jPZJkpwre4+2jght+1U+LM+7j
 6yymL9nDAtODucbYi5Op4IQp5/AkHPOyMM+iazbWqNavL4kylcGfIeSufamQWl1rwBZ2
 avHWNQyGj5g02sj3rObdDOUtGIEOt86JP3LV5Nu9BmmLsRYLlB5KcbAB/iVx6cNCM+LF
 D8Ynjmkd0rUgOBBShgsFXYz+JWLJr4oET6Meoyak/AqoKeJvDU9ww6GAoi4yxUgOKcPh gQ==
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
	by mx0a-001b2d01.pphosted.com with ESMTP id 37jhnm41pm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Mar 2021 01:03:26 -0400
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
	by ppma03dal.us.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 12U52ojg017666;
	Tue, 30 Mar 2021 05:03:24 GMT
Received: from b03cxnp08028.gho.boulder.ibm.com (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
	by ppma03dal.us.ibm.com with ESMTP id 37jtub50tr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Mar 2021 05:03:24 +0000
Received: from b03ledav005.gho.boulder.ibm.com (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
	by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 12U53NOt33685954
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 30 Mar 2021 05:03:23 GMT
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 286DABE054;
	Tue, 30 Mar 2021 05:03:23 +0000 (GMT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 02551BE056;
	Tue, 30 Mar 2021 05:03:20 +0000 (GMT)
Received: from skywalker.linux.ibm.com (unknown [9.199.52.226])
	by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTP;
	Tue, 30 Mar 2021 05:03:20 +0000 (GMT)
X-Mailer: emacs 28.0.50 (via feedmail 11-beta-1 I)
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To: Vaibhav Jain <vaibhav@linux.ibm.com>, linux-nvdimm@lists.01.org,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc/papr_scm: Mark nvdimm as unarmed if needed
 during probe
In-Reply-To: <20210329113103.476760-1-vaibhav@linux.ibm.com>
References: <20210329113103.476760-1-vaibhav@linux.ibm.com>
Date: Tue, 30 Mar 2021 10:33:18 +0530
Message-ID: <87k0pp6xnt.fsf@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: LhqZbeDmdCXDAw8XSe_vCeq7tXGk2ofH
X-Proofpoint-ORIG-GUID: LhqZbeDmdCXDAw8XSe_vCeq7tXGk2ofH
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-30_01:2021-03-26,2021-03-30 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 clxscore=1015
 mlxscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0
 mlxlogscore=999 bulkscore=0 phishscore=0 spamscore=0 impostorscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2103250000 definitions=main-2103300029
Message-ID-Hash: EXKBBJJ3KMJYIKEXELITKTHBYVHUUO7O
X-Message-ID-Hash: EXKBBJJ3KMJYIKEXELITKTHBYVHUUO7O
X-MailFrom: aneesh.kumar@linux.ibm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Vaibhav Jain <vaibhav@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, Shivaprasad G Bhat <sbhat@linux.ibm.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/EXKBBJJ3KMJYIKEXELITKTHBYVHUUO7O/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Vaibhav Jain <vaibhav@linux.ibm.com> writes:

> In case an nvdimm is found to be unarmed during probe then set its
> NDD_UNARMED flag before nvdimm_create(). This would enforce a
> read-only access to the ndimm region. Presently even if an nvdimm is
> unarmed its not marked as read-only on ppc64 guests.
>
> The patch updates papr_scm_nvdimm_init() to force query of nvdimm
> health via __drc_pmem_query_health() and if nvdimm is found to be
> unarmed then set the nvdimm flag ND_UNARMED for nvdimm_create().
>

Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>

> Signed-off-by: Vaibhav Jain <vaibhav@linux.ibm.com>
> ---
>  arch/powerpc/platforms/pseries/papr_scm.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/arch/powerpc/platforms/pseries/papr_scm.c b/arch/powerpc/platforms/pseries/papr_scm.c
> index 835163f54244..7e8168e19427 100644
> --- a/arch/powerpc/platforms/pseries/papr_scm.c
> +++ b/arch/powerpc/platforms/pseries/papr_scm.c
> @@ -914,6 +914,15 @@ static int papr_scm_nvdimm_init(struct papr_scm_priv *p)
>  	dimm_flags = 0;
>  	set_bit(NDD_LABELING, &dimm_flags);
>  
> +	/*
> +	 * Check if the nvdimm is unarmed. No locking needed as we are still
> +	 * initializing. Ignore error encountered if any.
> +	 */
> +	__drc_pmem_query_health(p);
> +
> +	if (p->health_bitmap & PAPR_PMEM_UNARMED_MASK)
> +		set_bit(NDD_UNARMED, &dimm_flags);
> +
>  	p->nvdimm = nvdimm_create(p->bus, p, papr_nd_attr_groups,
>  				  dimm_flags, PAPR_SCM_DIMM_CMD_MASK, 0, NULL);
>  	if (!p->nvdimm) {
> -- 
> 2.30.2
> _______________________________________________
> Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
> To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
