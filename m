Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A896D1DAFF2
	for <lists+linux-nvdimm@lfdr.de>; Wed, 20 May 2020 12:20:21 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 89B5611F2B5C2;
	Wed, 20 May 2020 03:16:56 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=vaibhav@linux.ibm.com; receiver=<UNKNOWN> 
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 8855311F2B5C0
	for <linux-nvdimm@lists.01.org>; Wed, 20 May 2020 03:16:54 -0700 (PDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04KA2CrK001868;
	Wed, 20 May 2020 06:19:46 -0400
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
	by mx0a-001b2d01.pphosted.com with ESMTP id 312cb1g4f6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 May 2020 06:19:46 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
	by ppma03ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 04KAGN8M024752;
	Wed, 20 May 2020 10:19:44 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
	by ppma03ams.nl.ibm.com with ESMTP id 313xas3dr0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 May 2020 10:19:43 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
	by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 04KAJfKo54001720
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 20 May 2020 10:19:41 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CA8A6A4055;
	Wed, 20 May 2020 10:19:41 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 47229A404D;
	Wed, 20 May 2020 10:19:39 +0000 (GMT)
Received: from vajain21-in-ibm-com (unknown [9.85.92.5])
	by d06av23.portsmouth.uk.ibm.com (Postfix) with SMTP;
	Wed, 20 May 2020 10:19:39 +0000 (GMT)
Received: by vajain21-in-ibm-com (sSMTP sendmail emulation); Wed, 20 May 2020 15:49:37 +0530
From: Vaibhav Jain <vaibhav@linux.ibm.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        linuxppc-dev@lists.ozlabs.org, linux-nvdimm@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH v7 4/5] ndctl/papr_scm,uapi: Add support for PAPR nvdimm specific methods
In-Reply-To: <87a723f5fs.fsf@linux.ibm.com>
References: <20200519190058.257981-1-vaibhav@linux.ibm.com> <20200519190058.257981-5-vaibhav@linux.ibm.com> <87a723f5fs.fsf@linux.ibm.com>
Date: Wed, 20 May 2020 15:49:37 +0530
Message-ID: <87y2pmx612.fsf@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-20_05:2020-05-19,2020-05-20 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 lowpriorityscore=0 mlxscore=0 suspectscore=1 spamscore=0 impostorscore=0
 malwarescore=0 adultscore=0 bulkscore=0 clxscore=1015 mlxlogscore=999
 priorityscore=1501 cotscore=-2147483648 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005200083
Message-ID-Hash: YGPW4SAQEGVG2SMTNJPVGUZRNHK7OLQF
X-Message-ID-Hash: YGPW4SAQEGVG2SMTNJPVGUZRNHK7OLQF
X-MailFrom: vaibhav@linux.ibm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Michael Ellerman <mpe@ellerman.id.au>, Steven Rostedt <rostedt@goodmis.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/YGPW4SAQEGVG2SMTNJPVGUZRNHK7OLQF/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Thanks for reviewing this patch Aneesh.

"Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com> writes:

> Vaibhav Jain <vaibhav@linux.ibm.com> writes:
>
> ....
>
>  +
>> +/* Papr-scm-header + payload expected with ND_CMD_CALL ioctl from libnvdimm */
>> +struct nd_pdsm_cmd_pkg {
>> +	struct nd_cmd_pkg hdr;	/* Package header containing sub-cmd */
>> +	__s32 cmd_status;	/* Out: Sub-cmd status returned back */
>> +	__u16 payload_offset;	/* In: offset from start of struct */
>> +	__u16 payload_version;	/* In/Out: version of the payload */
>> +	__u8 payload[];		/* In/Out: Sub-cmd data buffer */
>> +} __packed;
>
> that payload_offset can be avoided if we prevent userspace to user a
> different variant of nd_pdsm_cmd_pkg which different header. We can keep
> things simpler if we can always find payload at
> nd_pdsm_cmd_pkg->payload.
Had introduced this member to handle case where new fields are added to
'struct nd_pdsm_cmd_pkg' without having to break the ABI. But agree with
the point that you made later that this can be simplified by replacing
'payload_offset' with a set of reserved variables. Will address this in
next iteration of this patchset.

>
>> +
>> +/*
>> + * Methods to be embedded in ND_CMD_CALL request. These are sent to the kernel
>> + * via 'nd_pdsm_cmd_pkg.hdr.nd_command' member of the ioctl struct
>> + */
>> +enum papr_scm_pdsm {
>> +	PAPR_SCM_PDSM_MIN = 0x0,
>> +	PAPR_SCM_PDSM_MAX,
>> +};
>> +
>> +/* Convert a libnvdimm nd_cmd_pkg to pdsm specific pkg */
>> +static inline struct nd_pdsm_cmd_pkg *nd_to_pdsm_cmd_pkg(struct nd_cmd_pkg *cmd)
>> +{
>> +	return (struct nd_pdsm_cmd_pkg *) cmd;
>> +}
>> +
>> +/* Return the payload pointer for a given pcmd */
>> +static inline void *pdsm_cmd_to_payload(struct nd_pdsm_cmd_pkg *pcmd)
>> +{
>> +	if (pcmd->hdr.nd_size_in == 0 && pcmd->hdr.nd_size_out == 0)
>> +		return NULL;
>> +	else
>> +		return (void *)((__u8 *) pcmd + pcmd->payload_offset);
>> +}
>> +
>
> we need to make sure userspace is not passing a wrong payload_offset.
Agree, that this function should have more strict checking for
payload_offset field. However will be getting rid of
'payload_offset' all together in the next iteration as you previously
suggested.

> and in the next patch you do
>
> +	/* Copy the health struct to the payload */
> +	memcpy(pdsm_cmd_to_payload(pkg), &p->health, copysize);
> +	pkg->hdr.nd_fw_size = copysize;
> +
Yes this is already being done in the patchset and changes proposed to
this pdsm_cmd_to_payload() should not impact other patches as
pdsm_cmd_to_payload() abstracts rest of the code from how to access the
payload.

> All this can be simplified if you can keep payload at
> nd_pdsm_cmd_pkg->payload.
>
> If you still want to have the ability to extend the header, then added a
> reserved field similar to nd_cmd_pkg.
>
Agree to this and will address this in V8.

>
> -aneesh

-- 
Cheers
~ Vaibhav
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
