Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 776C81E3E25
	for <lists+linux-nvdimm@lfdr.de>; Wed, 27 May 2020 11:56:02 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 016B61226798A;
	Wed, 27 May 2020 02:51:51 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.158.5; helo=mx0a-001b2d01.pphosted.com; envelope-from=aneesh.kumar@linux.ibm.com; receiver=<UNKNOWN> 
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id B587E12267988
	for <linux-nvdimm@lists.01.org>; Wed, 27 May 2020 02:51:48 -0700 (PDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04R9WoM8073525;
	Wed, 27 May 2020 05:55:27 -0400
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com [169.55.91.170])
	by mx0a-001b2d01.pphosted.com with ESMTP id 316yqk54d9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 May 2020 05:55:27 -0400
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
	by ppma02wdc.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 04R9ZiIG016647;
	Wed, 27 May 2020 09:55:26 GMT
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com [9.57.198.29])
	by ppma02wdc.us.ibm.com with ESMTP id 316uf9p7sj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 May 2020 09:55:26 +0000
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com [9.57.199.109])
	by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 04R9tQwU47251768
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 27 May 2020 09:55:26 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6794A112062;
	Wed, 27 May 2020 09:55:26 +0000 (GMT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 37D52112065;
	Wed, 27 May 2020 09:55:24 +0000 (GMT)
Received: from skywalker.linux.ibm.com (unknown [9.85.125.124])
	by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTP;
	Wed, 27 May 2020 09:55:23 +0000 (GMT)
X-Mailer: emacs 27.0.91 (via feedmail 11-beta-1 I)
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To: Vaibhav Jain <vaibhav@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
        linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 4/5] ndctl/papr_scm,uapi: Add support for PAPR nvdimm
 specific methods
In-Reply-To: <20200527041244.37821-5-vaibhav@linux.ibm.com>
References: <20200527041244.37821-1-vaibhav@linux.ibm.com>
 <20200527041244.37821-5-vaibhav@linux.ibm.com>
Date: Wed, 27 May 2020 15:25:21 +0530
Message-ID: <87sgfl7ldi.fsf@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-05-27_03:2020-05-26,2020-05-27 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 suspectscore=0 clxscore=1015 priorityscore=1501 bulkscore=0
 lowpriorityscore=0 mlxlogscore=999 phishscore=0 adultscore=0 mlxscore=0
 spamscore=0 cotscore=-2147483648 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2005270068
Message-ID-Hash: MSANCNL7KROSMD5MB2H7QSGQGJNDNKZI
X-Message-ID-Hash: MSANCNL7KROSMD5MB2H7QSGQGJNDNKZI
X-MailFrom: aneesh.kumar@linux.ibm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Vaibhav Jain <vaibhav@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, Steven Rostedt <rostedt@goodmis.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/MSANCNL7KROSMD5MB2H7QSGQGJNDNKZI/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Vaibhav Jain <vaibhav@linux.ibm.com> writes:

> Introduce support for PAPR NVDIMM Specific Methods (PDSM) in papr_scm
> module and add the command family to the white list of NVDIMM command
> sets. Also advertise support for ND_CMD_CALL for the nvdimm
> command mask and implement necessary scaffolding in the module to
> handle ND_CMD_CALL ioctl and PDSM requests that we receive.
>
> The layout of the PDSM request as we expect from libnvdimm/libndctl is
> described in newly introduced uapi header 'papr_scm_pdsm.h' which
> defines a new 'struct nd_pdsm_cmd_pkg' header. This header is used
> to communicate the PDSM request via member
> 'nd_pkg_papr_scm->nd_command' and size of payload that need to be
> sent/received for servicing the PDSM.
>
> A new function is_cmd_valid() is implemented that reads the args to
> papr_scm_ndctl() and performs sanity tests on them. A new function
> papr_scm_service_pdsm() is introduced and is called from
> papr_scm_ndctl() in case of a PDSM request is received via ND_CMD_CALL
> command from libnvdimm.
>

Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>

> Cc: "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Vaibhav Jain <vaibhav@linux.ibm.com>
> ---

-aneesh
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
