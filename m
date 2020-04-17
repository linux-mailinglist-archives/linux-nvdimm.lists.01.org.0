Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 258921AD675
	for <lists+linux-nvdimm@lfdr.de>; Fri, 17 Apr 2020 08:51:54 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 340B8100DCB8D;
	Thu, 16 Apr 2020 23:52:10 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=vaibhav@linux.ibm.com; receiver=<UNKNOWN> 
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 2FDEE100DCB8C
	for <linux-nvdimm@lists.01.org>; Thu, 16 Apr 2020 23:52:07 -0700 (PDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03H6Xt9M066215
	for <linux-nvdimm@lists.01.org>; Fri, 17 Apr 2020 02:51:49 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
	by mx0a-001b2d01.pphosted.com with ESMTP id 30f05wt2w6-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-nvdimm@lists.01.org>; Fri, 17 Apr 2020 02:51:49 -0400
Received: from localhost
	by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-nvdimm@lists.01.org> from <vaibhav@linux.ibm.com>;
	Fri, 17 Apr 2020 07:51:08 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
	by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
	(version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
	Fri, 17 Apr 2020 07:51:06 +0100
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
	by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 03H6piZr48300076
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 17 Apr 2020 06:51:44 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 811F942047;
	Fri, 17 Apr 2020 06:51:44 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 93D1E4203F;
	Fri, 17 Apr 2020 06:51:42 +0000 (GMT)
Received: from vajain21.in.ibm.com (unknown [9.79.187.50])
	by d06av24.portsmouth.uk.ibm.com (Postfix) with SMTP;
	Fri, 17 Apr 2020 06:51:42 +0000 (GMT)
Received: by vajain21.in.ibm.com (sSMTP sendmail emulation); Fri, 17 Apr 2020 12:21:41 +0530
From: Vaibhav Jain <vaibhav@linux.ibm.com>
To: Ira Weiny <ira.weiny@intel.com>
Subject: Re: [ndctl PATCH] libndctl: Fix buffer 'offset' calculation in do_cmd()
In-Reply-To: <20200416200207.GN2309605@iweiny-DESK2.sc.intel.com>
References: <20200416185223.48486-1-vaibhav@linux.ibm.com> <20200416200207.GN2309605@iweiny-DESK2.sc.intel.com>
Date: Fri, 17 Apr 2020 12:21:41 +0530
MIME-Version: 1.0
X-TM-AS-GCONF: 00
x-cbid: 20041706-0016-0000-0000-0000030608DD
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20041706-0017-0000-0000-0000336A1049
Message-Id: <87lfmuwqo2.fsf@vajain21.in.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-17_01:2020-04-14,2020-04-17 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxscore=0
 bulkscore=0 malwarescore=0 phishscore=0 clxscore=1011 mlxlogscore=999
 suspectscore=7 adultscore=0 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004170046
Message-ID-Hash: NPU7ROZN2VVOGZMF6ZBQAYLYWOOTP6SJ
X-Message-ID-Hash: NPU7ROZN2VVOGZMF6ZBQAYLYWOOTP6SJ
X-MailFrom: vaibhav@linux.ibm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-nvdimm@lists.01.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/NPU7ROZN2VVOGZMF6ZBQAYLYWOOTP6SJ/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi,

Thanks for reviewing this patch. My responses below:

Ira Weiny <ira.weiny@intel.com> writes:

> On Fri, Apr 17, 2020 at 12:22:23AM +0530, Vaibhav Jain wrote:
>> The 'for' loop in do_cmd() that generates multiple ioctls to
>> libnvdimm assumes that each ioctl will result in transfer of
>> 'iter->max_xfer' bytes. Hence after each successful iteration the
>> buffer 'offset' is incremented by 'iter->max_xfer'.
>> 
>> This is in contrast to similar implementation in libnvdimm kernel
>> function nvdimm_get_config_data() which increments the buffer offset
>> by 'cmd->in_length' thats the actual number of bytes transferred from
>> the dimm/bus control function.
>> 
>> The implementation in kernel function nvdimm_get_config_data() is more
>> accurate compared to one in do_cmd() as former doesn't assume that
>> config/label-area data size is in multiples of 'iter->max_xfer'.
>> 
>> Hence the patch updates do_cmd() to increment the buffer 'offset'
>> variable by 'cmd->get_xfer()' rather than 'iter->max_xfer' after each
>> iteration.
>
> This commit message is not correct.  The problem is that commit
> a2fd7017b72d113ff7dfcf1b92b6a0a4de34c8b3 introduced the concept of
> {get,set}_xfer() and did not change the loop iterator to match.
The assumption to increment the buffer 'offset' by max_xfer instead of
*(cmd->iter.xfer) or get_xfer() predates the commit
a2fd7017b72d113ff7dfcf1b92b6a0a4de34c8b3

>
> Having the loop iterator match is not 100% required here as ->set_xfer() will
> only change alter the cmd length written on the final command when the loop is
> exiting anyway.
Agree that this condition is presently hit only at the final iteration
of the loop. But as the patch description points out that this differs
from the assumption made in kernel function nvdimm_get_config_data()
which doesnt assume that max_xfer bytes will be transffered at each
iteration.

Since the label area is stored separately from the nvdimm (in many cases
accessible only via slow i2c), a nvdimm/bus providers (like papr_scm)
may want to return xfer < max_xfer bytes for ND_CMD_GET_CONFIG_DATA
command without blocking.

nvdimm_get_config_data() provides this flexibility but do_cmd()
doesnt. Infact if a bus provider does such a thing then do_cmd() will
skip over the buffer range that was never trasffered to/from kernel.

>
> That said should set_xfer() ever do something more clever using get_xfer() is
> cleaner.
>
>> 
>> Signed-off-by: Vaibhav Jain <vaibhav@linux.ibm.com>
>> ---
>>  ndctl/lib/libndctl.c | 6 ++++--
>>  1 file changed, 4 insertions(+), 2 deletions(-)
>> 
>> diff --git a/ndctl/lib/libndctl.c b/ndctl/lib/libndctl.c
>> index cda17ff32410..24fa67f0ccd0 100644
>> --- a/ndctl/lib/libndctl.c
>> +++ b/ndctl/lib/libndctl.c
>> @@ -3089,7 +3089,7 @@ NDCTL_EXPORT int ndctl_cmd_xlat_firmware_status(struct ndctl_cmd *cmd)
>>  static int do_cmd(int fd, int ioctl_cmd, struct ndctl_cmd *cmd)
>>  {
>>  	int rc;
>> -	u32 offset;
>> +	u32 offset = 0;
>>  	const char *name, *sub_name = NULL;
>>  	struct ndctl_dimm *dimm = cmd->dimm;
>>  	struct ndctl_bus *bus = cmd_to_bus(cmd);
>> @@ -3116,7 +3116,7 @@ static int do_cmd(int fd, int ioctl_cmd, struct ndctl_cmd *cmd)
>>  			return rc;
>>  	}
>>  
>> -	for (offset = 0; offset < iter->total_xfer; offset += iter->max_xfer) {
>> +	while (offset < iter->total_xfer) {
>
> FWIW I prefer for loops if possible.
Sure will rework the for loop. Was just trying to avoid an ugly looking
for loop that didnt have an iteration-expression.

>
>>  		cmd->set_xfer(cmd, min(iter->total_xfer - offset,
>>  				iter->max_xfer));
>>  		cmd->set_offset(cmd, offset);
>> @@ -3136,6 +3136,8 @@ static int do_cmd(int fd, int ioctl_cmd, struct ndctl_cmd *cmd)
>>  			rc = offset + cmd->get_xfer(cmd) - rc;
>>  			break;
>>  		}
>> +
>> +		offset += cmd->get_xfer(cmd) - rc;
>
> Why "- rc"?  Doesn't this break WRITE?
Thanks for catching this. Will get it fixed.

>
> Ira
>
>>  	}
>>  
>>  	dbg(ctx, "bus: %d dimm: %#x cmd: %s%s%s total: %d max_xfer: %d status: %d fw: %d (%s)\n",
>> -- 
>> 2.25.2
>> _______________________________________________
>> Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
>> To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
> _______________________________________________
> Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
> To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

-- 
Vaibhav Jain <vaibhav@linux.ibm.com>
Linux Technology Center, IBM India Pvt. Ltd.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
