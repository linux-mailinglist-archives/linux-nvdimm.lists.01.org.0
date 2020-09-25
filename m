Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id ED0562792AE
	for <lists+linux-nvdimm@lfdr.de>; Fri, 25 Sep 2020 22:52:26 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id CA648155030A7;
	Fri, 25 Sep 2020 13:52:24 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=156.151.31.85; helo=userp2120.oracle.com; envelope-from=joao.m.martins@oracle.com; receiver=<UNKNOWN> 
Received: from userp2120.oracle.com (userp2120.oracle.com [156.151.31.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 3EF72154E35B1
	for <linux-nvdimm@lists.01.org>; Fri, 25 Sep 2020 13:52:22 -0700 (PDT)
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
	by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08PKmv4v039167;
	Fri, 25 Sep 2020 20:51:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=wN+2rYSC9ofNeKmi/78S9j/Oal936OwOLOU4JH5JdTk=;
 b=l2Zc8AaanbXbd0x81/d4RSfo7B1DvOom3kbSA/3lBQ+Yb0OmfaMI3VUk3OAckrxpW4VF
 QIkD6DDN9JapxrNrz0rIYkQDE2QNxlCaILEESwpCTOkoZE4xliMlu483RNLulgLhBeO2
 vw2tiAW+gsB5j10doRqXVYuuR27GomAeIb4yFkJf6Rk9ylL7kLB8ejL84muKtIRGe8X4
 ZbuSfqYn9O1s5go+NeJaEpR0HKSiDBJNDPVNHaQWUrrZyxUP2rDccnQMW9J5hq7Bd8Ky
 lqAPyKYHMyWpuOmXnUVlIe0YdiAHarIf1SRRiBGyY2mfLKy13G1JCm47XbNic8PrsO4B 7w==
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
	by userp2120.oracle.com with ESMTP id 33ndnuysd5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 25 Sep 2020 20:51:51 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
	by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08PKoYSj138802;
	Fri, 25 Sep 2020 20:51:50 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
	by aserp3030.oracle.com with ESMTP id 33s75kab32-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Sep 2020 20:51:50 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
	by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 08PKpWJN031863;
	Fri, 25 Sep 2020 20:51:32 GMT
Received: from [192.168.1.188] (/83.132.28.144)
	by default (Oracle Beehive Gateway v4.0)
	with ESMTP ; Fri, 25 Sep 2020 13:51:32 -0700
Subject: Re: [PATCH v5 00/17] device-dax: support sub-dividing soft-reserved
 ranges
To: Dan Williams <dan.j.williams@intel.com>, akpm@linux-foundation.org
References: <160106109960.30709.7379926726669669398.stgit@dwillia2-desk3.amr.corp.intel.com>
From: Joao Martins <joao.m.martins@oracle.com>
Message-ID: <8370d493-e38d-cbac-1233-14cbbef63936@oracle.com>
Date: Fri, 25 Sep 2020 21:51:22 +0100
MIME-Version: 1.0
In-Reply-To: <160106109960.30709.7379926726669669398.stgit@dwillia2-desk3.amr.corp.intel.com>
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9755 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0
 malwarescore=0 adultscore=0 phishscore=0 spamscore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009250150
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9755 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 lowpriorityscore=0 phishscore=0 adultscore=0 suspectscore=0 bulkscore=0
 clxscore=1011 impostorscore=0 mlxlogscore=999 mlxscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009250150
Message-ID-Hash: RLRCHDCEBOLMJNDUSPTQLOQHTMQOYDHE
X-Message-ID-Hash: RLRCHDCEBOLMJNDUSPTQLOQHTMQOYDHE
X-MailFrom: joao.m.martins@oracle.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: David Hildenbrand <david@redhat.com>, Bjorn Helgaas <bhelgaas@google.com>, Dave Hansen <dave.hansen@linux.intel.com>, David Airlie <airlied@linux.ie>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Pavel Tatashin <pasha.tatashin@soleen.com>, Hulk Robot <hulkci@huawei.com>, Ben Skeggs <bskeggs@redhat.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Jia He <justin.he@arm.com>, =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>, Jason Yan <yanaijie@huawei.com>, Paul Mackerras <paulus@ozlabs.org>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Brice Goglin <Brice.Goglin@inria.fr>, Stefano Stabellini <sstabellini@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>, Juergen Gross <jgross@suse.com>, Daniel Vetter <daniel@ffwll.ch>, linux-mm@kvack.org, linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/RLRCHDCEBOLMJNDUSPTQLOQHTMQOYDHE/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hey Dan,

On 9/25/20 8:11 PM, Dan Williams wrote:
> Changes since v4 [1]:
> - Rebased on
>   device-dax-move-instance-creation-parameters-to-struct-dev_dax_data.patch
>   in -mm [2]. I.e. patches that did not need fixups from v4 are not
>   included.
> 
> - Folded all fixes
> 

Hmm, perhaps you missed the fixups before the above mentioned patch?

From:

	https://www.ozlabs.org/~akpm/mmots/series

under "mm/dax", I am listing those fixups here:

x86-numa-add-nohmat-option-fix.patch
acpi-hmat-refactor-hmat_register_target_device-to-hmem_register_device-fix.patch
mm-memory_hotplug-introduce-default-phys_to_target_node-implementation-fix.patch
acpi-hmat-attach-a-device-for-each-soft-reserved-range-fix.patch

(in https://www.ozlabs.org/~akpm/mmots/broken-out/)

[...]

> ---
> 
> Andrew, this series replaces
> 
> device-dax-make-pgmap-optional-for-instance-creation.patch
> 
> ...through...
> 
> dax-hmem-introduce-dax_hmemregion_idle-parameter.patch
> 
> ...in your stack.
> 
> Let me know if there is a different / preferred way to refresh a bulk of
> patches in your queue when only a subset need updates.
> 
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
