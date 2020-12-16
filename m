Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34E752DC864
	for <lists+linux-nvdimm@lfdr.de>; Wed, 16 Dec 2020 22:35:25 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 8750B100EBB61;
	Wed, 16 Dec 2020 13:35:23 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=141.146.126.79; helo=aserp2130.oracle.com; envelope-from=joao.m.martins@oracle.com; receiver=<UNKNOWN> 
Received: from aserp2130.oracle.com (aserp2130.oracle.com [141.146.126.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 7195E100EBBDF
	for <linux-nvdimm@lists.01.org>; Wed, 16 Dec 2020 13:35:21 -0800 (PST)
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
	by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0BGLNhpB057919;
	Wed, 16 Dec 2020 21:35:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=aWvCHegSbG3j/X2z1f3hYNuJggyPL4DRWvyIGMZLvSo=;
 b=E9ONFtT6KuYYQMTW7PlYzk/LoJeoExwf+xSvdhO5zUYjwpRLM66nJT/yP3Xk3JaOAhCs
 Icbu39vN6Ky7wZo0qriH49r6GaIoVp38kfm5AtxS5hz2qpzZOk2xyfg8fPX9qxXLMnHT
 6jjaHfU0Gifn4/JSNHtfQ72bAqxymzgkCHeQKiao3Htx0poxNnbWM2jZE7s3JVXUDGfj
 0v+yRjFutEmlgfZedoURr9jAm4LNbFvwDMVIZ/tx7biwm/UHEkAP3fSeGRutZ/nADQB5
 XYd73zKpzQvDoHVIoBITYdfS51JI9gAtTnM+ZOkezIp75buAns4Kjlbfd601uQ4VJD13 yg==
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
	by aserp2130.oracle.com with ESMTP id 35ckcbjrk5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 16 Dec 2020 21:35:19 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
	by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0BGLPEwk084097;
	Wed, 16 Dec 2020 21:35:18 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
	by userp3020.oracle.com with ESMTP id 35e6jtbvj0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Dec 2020 21:35:18 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
	by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0BGLZHi4023637;
	Wed, 16 Dec 2020 21:35:17 GMT
Received: from [10.175.172.71] (/10.175.172.71)
	by default (Oracle Beehive Gateway v4.0)
	with ESMTP ; Wed, 16 Dec 2020 13:35:17 -0800
Subject: Re: [PATCH ndctl v1 0/8] daxctl: Add device align and range mapping
 allocation
To: Dan Williams <dan.j.williams@intel.com>
References: <20200716184707.23018-1-joao.m.martins@oracle.com>
 <988f8189-b20c-d569-91f0-cf31033cf9d7@oracle.com>
 <CAPcyv4gWry3r8a46X9pnobFNwjQLqG-N2MyvKsx7abJhjadYTQ@mail.gmail.com>
From: Joao Martins <joao.m.martins@oracle.com>
Message-ID: <0d77da52-c84f-5753-b55b-e510e807f151@oracle.com>
Date: Wed, 16 Dec 2020 21:35:14 +0000
MIME-Version: 1.0
In-Reply-To: <CAPcyv4gWry3r8a46X9pnobFNwjQLqG-N2MyvKsx7abJhjadYTQ@mail.gmail.com>
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9837 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 bulkscore=0
 malwarescore=0 adultscore=0 mlxlogscore=999 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012160134
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9837 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999
 priorityscore=1501 mlxscore=0 suspectscore=0 adultscore=0 phishscore=0
 malwarescore=0 impostorscore=0 lowpriorityscore=0 clxscore=1015
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012160134
Message-ID-Hash: RNJWWJTNO7JZGOORMIYT6BPYDGN2Z7HZ
X-Message-ID-Hash: RNJWWJTNO7JZGOORMIYT6BPYDGN2Z7HZ
X-MailFrom: joao.m.martins@oracle.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-nvdimm <linux-nvdimm@lists.01.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/RNJWWJTNO7JZGOORMIYT6BPYDGN2Z7HZ/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 12/16/20 7:13 PM, Dan Williams wrote:
> On Wed, Dec 16, 2020 at 3:41 AM Joao Martins <joao.m.martins@oracle.com> wrote:
>>
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
>>>       --mapping <pgoff>:<start>-<end>
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
> 
> What's the breakage with older kernels, is it the kernel regressing
> old daxctl, or is it new daxctl being incompatible with old kernels?
> If it's the latter, it needs a fixup, if it's the former it needs a
> kernel compat change.

It's the latter i.e. new daxctl being incompatible with old kernels, because of a change
in the first patch. Essentially a wrong assumption of device align being always available
in add_dax_dev().

The fixup would be this snip below to the first patch. But I will respin the first four
patches today or my morning tomorrow, with a test.

diff --git a/daxctl/lib/libdaxctl.c b/daxctl/lib/libdaxctl.c
index 14bf48dd00bf..b01cc916eb6e 100644
--- a/daxctl/lib/libdaxctl.c
+++ b/daxctl/lib/libdaxctl.c
@@ -498,10 +498,12 @@ static void *add_dax_dev(void *parent, int id, const char *daxdev_base)
                goto err_read;
        dev->size = strtoull(buf, NULL, 0);

+       /* Device align attribute is only available in v5.10 or up */
        sprintf(path, "%s/align", daxdev_base);
-       if (sysfs_read_attr(ctx, path, buf) < 0)
-               goto err_read;
-       dev->align = strtoull(buf, NULL, 0);
+       if (!sysfs_read_attr(ctx, path, buf))
+               dev->align = strtoull(buf, NULL, 0);
+       else
+               dev->align = 0;

        dev->dev_path = strdup(daxdev_base);
        if (!dev->dev_path)
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
