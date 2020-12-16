Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AE5AB2DBF95
	for <lists+linux-nvdimm@lfdr.de>; Wed, 16 Dec 2020 12:41:26 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id E6BB0100EC1FB;
	Wed, 16 Dec 2020 03:41:24 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=141.146.126.78; helo=aserp2120.oracle.com; envelope-from=joao.m.martins@oracle.com; receiver=<UNKNOWN> 
Received: from aserp2120.oracle.com (aserp2120.oracle.com [141.146.126.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 65B45100EC1F9
	for <linux-nvdimm@lists.01.org>; Wed, 16 Dec 2020 03:41:21 -0800 (PST)
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
	by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0BGBXnUK010454;
	Wed, 16 Dec 2020 11:41:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : from : to :
 cc : references : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=h1UQ1ELDyn5CZXZ6fUo+8/hzzHFHeyYaMRwfc1y8xu8=;
 b=qMu5rq3O9dqNsi9WYFofLlwn8LiCbiHbIUMV1xBvrTUdw8RynNGjM5tW1Qv8Sz/HRHuQ
 lhWffd030hBdL3M9ktOQS3hY+7tWICZ80p2IH9D1C3ulBdHzC4z7+bcDnO1NhRkXtkJc
 IPCGpoZPQCpoHbwxFTSETvDYtKn0ezstrdwYX2X7sPZzT1n1r5fNrTHs2fF3a2JI6GK6
 1yTWMO7ru4UWGefj/Oru9NQ3ZbCJozZtQPBujTf6guT4MLRBjqhlF8oQYuEf4rgpSXXf
 8ov591/iLlZ85XREJQMu6S25EdVi54BISphk7WJIR61Oij694Tum5GuCLvuSPp6bt1r3 tQ==
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
	by aserp2120.oracle.com with ESMTP id 35cntm7nbb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 16 Dec 2020 11:41:19 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
	by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0BGBZFHA176340;
	Wed, 16 Dec 2020 11:39:18 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
	by aserp3030.oracle.com with ESMTP id 35d7epd96u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Dec 2020 11:39:18 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
	by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0BGBdHRY026800;
	Wed, 16 Dec 2020 11:39:17 GMT
Received: from [10.175.202.27] (/10.175.202.27)
	by default (Oracle Beehive Gateway v4.0)
	with ESMTP ; Wed, 16 Dec 2020 03:39:17 -0800
Subject: Re: [PATCH ndctl v1 0/8] daxctl: Add device align and range mapping
 allocation
From: Joao Martins <joao.m.martins@oracle.com>
To: linux-nvdimm@lists.01.org
Cc: Vishal Verma <vishal.l.verma@intel.com>,
        Dan Williams <dan.j.williams@intel.com>
References: <20200716184707.23018-1-joao.m.martins@oracle.com>
Message-ID: <988f8189-b20c-d569-91f0-cf31033cf9d7@oracle.com>
Date: Wed, 16 Dec 2020 11:39:14 +0000
MIME-Version: 1.0
In-Reply-To: <20200716184707.23018-1-joao.m.martins@oracle.com>
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9836 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 bulkscore=0
 suspectscore=0 adultscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012160075
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9836 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 mlxscore=0
 lowpriorityscore=0 spamscore=0 adultscore=0 malwarescore=0 suspectscore=0
 mlxlogscore=999 impostorscore=0 priorityscore=1501 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012160075
Message-ID-Hash: RGEKA6LQFLB6ISV3LI6FKUIOS6XIN4AH
X-Message-ID-Hash: RGEKA6LQFLB6ISV3LI6FKUIOS6XIN4AH
X-MailFrom: joao.m.martins@oracle.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/RGEKA6LQFLB6ISV3LI6FKUIOS6XIN4AH/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 7/16/20 7:46 PM, Joao Martins wrote:
> Hey,
> 
> This series builds on top of this one[0] and does the following improvements
> to the Soft-Reserved subdivision:
> 
>  1) Support for {create,reconfigure}-device for selecting @align (hugepage size).
>  Here we add a '-a|--align 4K|2M|1G' option to the existing commands;
> 
>  2) Listing improvements for device alignment and mappings;
>  Note: Perhaps it is better to hide the mappings by default, and only
>        print with -v|--verbose. This would align with ndctl, as the mappings
>        info can be quite large.
> 
>  3) Allow creating devices from selecting ranges. This allows to keep the
>    same GPA->HPA mapping as before we kexec the hypervisor with running guests:
> 
>    daxctl list -d dax0.1 > /var/log/dax0.1.json
>    kexec -d -l bzImage
>    systemctl kexec
>    daxctl create -u --restore /var/log/dax0.1.json
> 
>    The JSON was what I though it would be easier for an user, given that it is
>    the data format daxctl outputs. Alternatives could be adding multiple:
>    	--mapping <pgoff>:<start>-<end>
> 
>    But that could end up in a gigantic line and a little more
>    unmanageable I think.
> 
> This series requires this series[0] on top of Dan's patches[1]:
> 
>  [0] https://lore.kernel.org/linux-nvdimm/20200716172913.19658-1-joao.m.martins@oracle.com/
>  [1] https://lore.kernel.org/linux-nvdimm/159457116473.754248.7879464730875147365.stgit@dwillia2-desk3.amr.corp.intel.com/
> 
> The only TODO here is docs and improving tests to validate mappings, and test
> the restore path.
> 
> Suggestions/comments are welcome.
> 
There's a couple of issues in this series regarding daxctl-reconfigure options and
breakage of ndctl with kernels (<5.10) that do not supply a device @align upon testing
with NVDIMMs. Plus it is missing daxctl-create.sh unit test for @align.

I will fix those and respin, and probably take out the last patch as it's more RFC-ish and
in need of feedback.

	Joao

> Joao Martins (8):
>   daxctl: add daxctl_dev_{get,set}_align()
>   util/json: Print device align
>   daxctl: add align support in reconfigure-device
>   daxctl: add align support in create-device
>   libdaxctl: add mapping iterator APIs
>   daxctl: include mappings when listing
>   libdaxctl: add daxctl_dev_set_mapping()
>   daxctl: Allow restore devices from JSON metadata
> 
>  daxctl/device.c                | 154 +++++++++++++++++++++++++++++++++++++++--
>  daxctl/lib/libdaxctl-private.h |   9 +++
>  daxctl/lib/libdaxctl.c         | 152 +++++++++++++++++++++++++++++++++++++++-
>  daxctl/lib/libdaxctl.sym       |   9 +++
>  daxctl/libdaxctl.h             |  16 +++++
>  util/json.c                    |  63 ++++++++++++++++-
>  util/json.h                    |   3 +
>  7 files changed, 396 insertions(+), 10 deletions(-)
> 
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
