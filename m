Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BD46228DD3
	for <lists+linux-nvdimm@lfdr.de>; Wed, 22 Jul 2020 04:00:06 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 808DE1245F40C;
	Tue, 21 Jul 2020 19:00:04 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=vaibhav@linux.ibm.com; receiver=<UNKNOWN> 
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 626C911B961EA
	for <linux-nvdimm@lists.01.org>; Tue, 21 Jul 2020 19:00:02 -0700 (PDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06M1a6GY083849;
	Tue, 21 Jul 2020 22:00:00 -0400
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
	by mx0a-001b2d01.pphosted.com with ESMTP id 32e1xx08d9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 21 Jul 2020 22:00:00 -0400
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
	by ppma03fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 06M1oKfF021883;
	Wed, 22 Jul 2020 01:59:58 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
	by ppma03fra.de.ibm.com with ESMTP id 32brq82a97-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Jul 2020 01:59:57 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
	by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 06M1xtMa19792188
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 22 Jul 2020 01:59:55 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C59C742047;
	Wed, 22 Jul 2020 01:59:55 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 29D584203F;
	Wed, 22 Jul 2020 01:59:53 +0000 (GMT)
Received: from vajain21-in-ibm-com (unknown [9.85.89.254])
	by d06av24.portsmouth.uk.ibm.com (Postfix) with SMTP;
	Wed, 22 Jul 2020 01:59:52 +0000 (GMT)
Received: by vajain21-in-ibm-com (sSMTP sendmail emulation); Wed, 22 Jul 2020 07:29:51 +0530
From: Vaibhav Jain <vaibhav@linux.ibm.com>
To: Vishal Verma <vishal.l.verma@intel.com>, linux-nvdimm@lists.01.org
Subject: Re: [ndctl PATCH] papr: Check for command type in papr_xlat_firmware_status()
In-Reply-To: <3a1ed55273a2c901228f5f6bc1824707a70d6dcb.camel@intel.com>
References: <20200721114326.305790-1-vaibhav@linux.ibm.com> <3a1ed55273a2c901228f5f6bc1824707a70d6dcb.camel@intel.com>
Date: Wed, 22 Jul 2020 07:29:51 +0530
Message-ID: <87pn8o48dk.fsf@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-22_01:2020-07-21,2020-07-21 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 priorityscore=1501 bulkscore=0 mlxlogscore=999 clxscore=1015 phishscore=0
 mlxscore=0 lowpriorityscore=0 suspectscore=1 impostorscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007220008
Message-ID-Hash: 4I7QHLBTFZHTDRY5WFHY55K354VFDBMK
X-Message-ID-Hash: 4I7QHLBTFZHTDRY5WFHY55K354VFDBMK
X-MailFrom: vaibhav@linux.ibm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/4I7QHLBTFZHTDRY5WFHY55K354VFDBMK/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Vishal Verma <vishal.l.verma@intel.com> writes:

<snip>
>>  static int papr_xlat_firmware_status(struct ndctl_cmd *cmd)
>>  {
>> -	const struct nd_pkg_pdsm *pcmd = to_pdsm(cmd);
>> -
>> -	return pcmd->cmd_status;
>> +	return (cmd->type == ND_CMD_CALL) ? to_pdsm(cmd)->cmd_status : 0;
>
> Is this correct? -- for non ND_CMD_CALL commands this will always return a 0,
> and it seems like you will lose any error state for commands
> like ND_CMD_SET_CONFIG_DATA.
This behaviour is similar to what ndctl_cmd_xlat_firmware_status() does
when corresponding dimm-ops are missing the 'xlat_firmware_status'
callback.

Also ndctl_cmd_submit_xlat() returns the rc from ndctl_cmd_submit()
in case ndctl_cmd_xlat_firmware_status() returns '0', which corresponds
to 'ndctl_cmd.status' field. So any error codes
returned from ndctl_cmd_submit() are still returned back to the caller
even though papr_xlat_firmware_status() returned '0'. 
>
>>  }
>>  
>>  /* Verify if the given command is supported and valid */
>
>

-- 
Cheers
~ Vaibhav
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
