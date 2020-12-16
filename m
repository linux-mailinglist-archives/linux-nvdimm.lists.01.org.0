Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 822CE2DC880
	for <lists+linux-nvdimm@lfdr.de>; Wed, 16 Dec 2020 22:51:21 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id C45B7100EBBC1;
	Wed, 16 Dec 2020 13:51:19 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=156.151.31.86; helo=userp2130.oracle.com; envelope-from=joao.m.martins@oracle.com; receiver=<UNKNOWN> 
Received: from userp2130.oracle.com (userp2130.oracle.com [156.151.31.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 5B68F100EBBB9
	for <linux-nvdimm@lists.01.org>; Wed, 16 Dec 2020 13:51:18 -0800 (PST)
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
	by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0BGLiYVh146046;
	Wed, 16 Dec 2020 21:51:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=lj23Je/oshLY9DG399P1wvwy2j9UHJVkLwkwV3ZKstk=;
 b=Dnd79A+YsZoyGdXSeALZhpPuT4aDA+0ehnPB9D1aOKugdQfv94Mz41FdBnB7geSwIyTi
 ktpJbOYRs9Xs/tDqwu2BrcRSI764r3W2qskbFJll8NBISvx78CdWx3uYAN5Sz6nS+8q6
 jTBdLfTS0fCA+vPMMZ2rEq4Gl/vj2VjcSz0BEAC8oIh3wZRAM01idjLFg+RZX9OXBiyJ
 AKyAJQXsxxm7HmjFbMnjlbohZFnOHPwWYmPE1ArPirh1Tgo/Q2Fh3YZSMgQ+u1WEDjUs
 NOfQyBuIltBlCsCeWBgNPo4NfoIaGVxbJFu3CfknhXMTfxg/dMzmd13/+7mjnlTevyd4 Jg==
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
	by userp2130.oracle.com with ESMTP id 35cn9rjn7p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 16 Dec 2020 21:51:16 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
	by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0BGLjFg7137037;
	Wed, 16 Dec 2020 21:49:16 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
	by userp3020.oracle.com with ESMTP id 35e6jtccx0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Dec 2020 21:49:16 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
	by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0BGLnEpT000596;
	Wed, 16 Dec 2020 21:49:15 GMT
Received: from [10.175.172.71] (/10.175.172.71)
	by default (Oracle Beehive Gateway v4.0)
	with ESMTP ; Wed, 16 Dec 2020 13:49:14 -0800
Subject: Re: [PATCH ndctl v1 0/8] daxctl: Add device align and range mapping
 allocation
To: "Verma, Vishal L" <vishal.l.verma@intel.com>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>
Cc: "Williams, Dan J" <dan.j.williams@intel.com>
References: <20200716184707.23018-1-joao.m.martins@oracle.com>
 <988f8189-b20c-d569-91f0-cf31033cf9d7@oracle.com>
 <9db17315af1440b805c4fed2338969e7fe3155ec.camel@intel.com>
From: Joao Martins <joao.m.martins@oracle.com>
Message-ID: <1ba4fc06-a13a-ce2b-2f53-95a913ac3a8e@oracle.com>
Date: Wed, 16 Dec 2020 21:49:10 +0000
MIME-Version: 1.0
In-Reply-To: <9db17315af1440b805c4fed2338969e7fe3155ec.camel@intel.com>
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9837 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 bulkscore=0
 malwarescore=0 adultscore=0 mlxlogscore=999 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012160135
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9837 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 impostorscore=0 lowpriorityscore=0 clxscore=1015 spamscore=0
 malwarescore=0 priorityscore=1501 phishscore=0 mlxscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012160135
Message-ID-Hash: G6J62CLKBZJKIH6P552E722JSL7BJVQX
X-Message-ID-Hash: G6J62CLKBZJKIH6P552E722JSL7BJVQX
X-MailFrom: joao.m.martins@oracle.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/G6J62CLKBZJKIH6P552E722JSL7BJVQX/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 12/16/20 6:42 PM, Verma, Vishal L wrote:
> On Wed, 2020-12-16 at 11:39 +0000, Joao Martins wrote:
>> On 7/16/20 7:46 PM, Joao Martins wrote:
>>> Hey,
>>>
>>> This series builds on top of this one[0] and does the following improvements
>>> to the Soft-Reserved subdivision:
>>>
>>>  1) Support for {create,reconfigure}-device for selecting @align (hugepage size).
>>>  Here we add a '-a|--align 4K|2M|1G' option to the existing commands;
>>>
>>>  2) Listing improvements for device alignment and mappings;
>>>  Note: Perhaps it is better to hide the mappings by default, and only
>>>        print with -v|--verbose. This would align with ndctl, as the mappings
>>>        info can be quite large.
>>>
>>>  3) Allow creating devices from selecting ranges. This allows to keep the
>>>    same GPA->HPA mapping as before we kexec the hypervisor with running guests:
>>>
>>>    daxctl list -d dax0.1 > /var/log/dax0.1.json
>>>    kexec -d -l bzImage
>>>    systemctl kexec
>>>    daxctl create -u --restore /var/log/dax0.1.json
>>>
>>>    The JSON was what I though it would be easier for an user, given that it is
>>>    the data format daxctl outputs. Alternatives could be adding multiple:
>>>    	--mapping <pgoff>:<start>-<end>
>>>
>>>    But that could end up in a gigantic line and a little more
>>>    unmanageable I think.
>>>
>>> This series requires this series[0] on top of Dan's patches[1]:
>>>
>>>  [0] https://lore.kernel.org/linux-nvdimm/20200716172913.19658-1-joao.m.martins@oracle.com/
>>>  [1] https://lore.kernel.org/linux-nvdimm/159457116473.754248.7879464730875147365.stgit@dwillia2-desk3.amr.corp.intel.com/
>>>
>>> The only TODO here is docs and improving tests to validate mappings, and test
>>> the restore path.
>>>
>>> Suggestions/comments are welcome.
>>>
>> There's a couple of issues in this series regarding daxctl-reconfigure options and
>> breakage of ndctl with kernels (<5.10) that do not supply a device @align upon testing
>> with NVDIMMs. Plus it is missing daxctl-create.sh unit test for @align.
>>
>> I will fix those and respin, and probably take out the last patch as it's more RFC-ish and
>> in need of feedback.
> 
> Sounds good. Any objections to releasing v70 with the initial support,
> and then adding this series on for the next one? I'm thinking I'll do a
> much quicker v72 release say in early January with this and anything
> else that missed v71.

If we're able to wait until tomorrow, I could respin these first four patches with the
fixes and include the align support in the initial set. Otherwise, I am also good if you
prefer defering it to v72.

	Joao
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
