Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 435CC21D31C
	for <lists+linux-nvdimm@lfdr.de>; Mon, 13 Jul 2020 11:46:29 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 9B4F61172EFBA;
	Mon, 13 Jul 2020 02:46:27 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=156.151.31.85; helo=userp2120.oracle.com; envelope-from=joao.m.martins@oracle.com; receiver=<UNKNOWN> 
Received: from userp2120.oracle.com (userp2120.oracle.com [156.151.31.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id DA4DE1170194E
	for <linux-nvdimm@lists.01.org>; Mon, 13 Jul 2020 02:46:25 -0700 (PDT)
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
	by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06D9WoDU186747;
	Mon, 13 Jul 2020 09:46:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=PxyM3iaI6wn6JuO5xz2u2JKizc6ysmncBc89RQdV9+E=;
 b=BJcbMsTBRBPrPo1KdJmz90EGPdHym91KNvptLl+DW7ZthLgoUbWu+pY/TF+Lfu/3t1yi
 8U2rvNji9Kzxozf9i2LJlCXBKrq17SSKiDFz1CAS+W6Rc2lNPMEuj3+214HRADgz/RaQ
 9x5eF97ImG+SNADLIJjQOwJMp1gtsSgbVFses0qy7njcwKxR7rCIbtKXuXzSBCG2vS0E
 W4bPNLI2DYN2H1rjZ5BMsFJdagCf3DTUJ75X6gdGksuRjlLL0/HON3HxhhzsXrbaU38L
 FLl9RZaXUHnI8TmUWxGma4iU7DP+oJeHqCxo91hYMd28u+3nec+j/7f080VhnMLpp9jP Ew==
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
	by userp2120.oracle.com with ESMTP id 32762n5x3q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 13 Jul 2020 09:46:23 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
	by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06D9TUdO025732;
	Mon, 13 Jul 2020 09:46:23 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
	by aserp3020.oracle.com with ESMTP id 327qb065y5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 13 Jul 2020 09:46:22 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
	by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 06D9kLnF009039;
	Mon, 13 Jul 2020 09:46:21 GMT
Received: from [10.175.167.147] (/10.175.167.147)
	by default (Oracle Beehive Gateway v4.0)
	with ESMTP ; Mon, 13 Jul 2020 02:46:21 -0700
Subject: Re: [PATCH ndctl v1 10/10] daxctl/test: Add tests for dynamic dax
 regions
To: Dan Williams <dan.j.williams@intel.com>
References: <20200403205900.18035-1-joao.m.martins@oracle.com>
 <20200403205900.18035-11-joao.m.martins@oracle.com>
 <CAPcyv4g=KifpmjbQYZYnxxYn=W0NBogvr6kGR3+bX14opYEZ=w@mail.gmail.com>
From: Joao Martins <joao.m.martins@oracle.com>
Message-ID: <428e465e-44ca-0ba1-4e17-1d9cd026ae39@oracle.com>
Date: Mon, 13 Jul 2020 10:46:19 +0100
MIME-Version: 1.0
In-Reply-To: <CAPcyv4g=KifpmjbQYZYnxxYn=W0NBogvr6kGR3+bX14opYEZ=w@mail.gmail.com>
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9680 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 mlxscore=0 spamscore=0 phishscore=0 suspectscore=1 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007130072
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9680 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 spamscore=0
 clxscore=1011 priorityscore=1501 mlxlogscore=999 lowpriorityscore=0
 bulkscore=0 suspectscore=1 phishscore=0 adultscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007130072
Message-ID-Hash: 4FJY445SJSJUNKR62UAH3MEOV26Z2LGH
X-Message-ID-Hash: 4FJY445SJSJUNKR62UAH3MEOV26Z2LGH
X-MailFrom: joao.m.martins@oracle.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-nvdimm <linux-nvdimm@lists.01.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/4FJY445SJSJUNKR62UAH3MEOV26Z2LGH/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 7/12/20 4:04 PM, Dan Williams wrote:
> On Fri, Apr 3, 2020 at 1:59 PM Joao Martins <joao.m.martins@oracle.com> wrote:
>>
>> Add a couple tests which exercise the new sysfs based
>> interface for Soft-Reserved regions (by EFI/HMAT, or
>> efi_fake_mem).
>>
>> The tests exercise the daxctl orchestration surrounding
>> for creating/disabling/destroying/reconfiguring devices.
>> Furthermore it exercises dax region space allocation
>> code paths particularly:
>>
>>  1) zeroing out and reconfiguring a dax device from
>>  its current size to be max available and back to initial
>>  size
>>
>>  2) creates devices from holes in the beginning,
>>  middle of the region.
>>
>>  3) reconfigures devices in a interleaving fashion
>>
>>  4) test adjust of the region towards beginning and end
>>
>> The tests assume you pass a valid efi_fake_mem parameter
>> marked as EFI_MEMORY_SP e.g.
>>
>>         efi_fake_mem=112G@16G:0x40000
>>
>> Naturally it bails out from the test if hmem device driver
>> isn't loaded/builtin or no region is found.
> 
> So, I finally have the kernel passing this test. Thank you! I did
> notice that I need to make sure that there is only one hmem range
> defined otherwise the test gets confused and fails. I expect it spills
> over to other regions when the test expects that the region should be
> full. Could you take a look at adjusting the test to constrain its
> allocations to a single region?
> 
Yeap, will fix and send v2.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
