Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E14D4B3FD9
	for <lists+linux-nvdimm@lfdr.de>; Mon, 16 Sep 2019 19:58:52 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 1F89021962301;
	Mon, 16 Sep 2019 10:58:20 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::342; helo=mail-ot1-x342.google.com;
 envelope-from=dan.j.williams@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com
 [IPv6:2607:f8b0:4864:20::342])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 5B6A221962301
 for <linux-nvdimm@lists.01.org>; Mon, 16 Sep 2019 10:58:17 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id 41so600511oti.12
 for <linux-nvdimm@lists.01.org>; Mon, 16 Sep 2019 10:58:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ZBfYJ19Paf/hLNb6Ye+v7jwhGQnHf20AdY/r84fczKU=;
 b=X6PKCigrLZVQCT1SP1gKVoiux5EZZKkTQj12/WROSndrvqr//HdL312ewutOhqJa88
 jkSjVvdpMOeRtXnNEEGfzUj682H0ZmpXYakGVRHCeY1ceddIQo77hO5KjjJP73fQ0e42
 HTXz9uuCKFJ440fC2CkILfkOOxAZL7RukPnCeTC0N3KJjVd1U7Lq5yi63ppcv6okwTWZ
 b2Rz4OBPUjaTVYBGJb2qPPzRcxYu9oHDFhgDlUnoj90AesEAhmYB6so0O9S0AFNVZwjN
 mI3PIxVPe9NcA4aINs/FCDbO6ubqumJ+HDpPWSdvlBm9xHq9YPQa93nL6RZwVYukz0at
 vTmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ZBfYJ19Paf/hLNb6Ye+v7jwhGQnHf20AdY/r84fczKU=;
 b=RGBPaPAykrzWwuwnonpSi3JVyvba8eGGkWU6RaTGDFSt1HGdfbcKlnO7INdP0CJ4uY
 L95GIOk8YpjryHgoPTD6CjYob04CHGX9ofrcslIEUb7LgzeDm9Rq8RiwJuw0ZinyA18R
 hpeSgCvsqFK8WVs+FWcegWlmysP7VNChL7CwiuFugxJWHVsggrOnPT9/qCYmC9RIpsE+
 QTEYDBRJrDRobUU2175pIixKN5qT7USv5M6F2sF58CTo8ae3svrovQj9nYB/bL3fckXZ
 ugyxC+dQI3YE5bB3kVWVnoTF3dS/6qFwdMsF+8KFCz9dIZmZn7KGR0/M+aKd+PSKBpXu
 fDXQ==
X-Gm-Message-State: APjAAAWYeRP1RnIF3BhrppqlqgCURG2W7UNKQiYdtxnrmy9OYsGjWLBF
 pznwnQ+GLSBjSA0nuRTU1+JnVJhsvW7Euk3BRq0Pqg==
X-Google-Smtp-Source: APXvYqzl+/Oe+SRra63pGxDCtiBTcyBjkrohjtozYl23XPCexO8fRxaxITWvLOiewMLUwPLPIcQcK4eZ0yf2bh7fVHs=
X-Received: by 2002:a9d:3a6:: with SMTP id f35mr301938otf.363.1568656727910;
 Mon, 16 Sep 2019 10:58:47 -0700 (PDT)
MIME-Version: 1.0
References: <20190910062826.10041-1-aneesh.kumar@linux.ibm.com>
In-Reply-To: <20190910062826.10041-1-aneesh.kumar@linux.ibm.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Mon, 16 Sep 2019 10:58:36 -0700
Message-ID: <CAPcyv4g2jAGzQ3fxpZRTV16hoPfyXqzvB7Zny6D5g5JyAQ1Dkw@mail.gmail.com>
Subject: Re: [PATCH 1/2] libnvdimm/altmap: Track namespace boundaries in altmap
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
X-BeenThere: linux-nvdimm@lists.01.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
List-Unsubscribe: <https://lists.01.org/mailman/options/linux-nvdimm>,
 <mailto:linux-nvdimm-request@lists.01.org?subject=unsubscribe>
List-Archive: <http://lists.01.org/pipermail/linux-nvdimm/>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Subscribe: <https://lists.01.org/mailman/listinfo/linux-nvdimm>,
 <mailto:linux-nvdimm-request@lists.01.org?subject=subscribe>
Cc: Sachin Sant <sachinp@linux.vnet.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 linux-nvdimm <linux-nvdimm@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Mon, Sep 9, 2019 at 11:29 PM Aneesh Kumar K.V
<aneesh.kumar@linux.ibm.com> wrote:
>
> With PFN_MODE_PMEM namespace, the memmap area is allocated from the device
> area. Some architectures map the memmap area with large page size. On
> architectures like ppc64, 16MB page for memap mapping can map 262144 pfns.
> This maps a namespace size of 16G.
>
> When populating memmap region with 16MB page from the device area,
> make sure the allocated space is not used to map resources outside this
> namespace. Such usage of device area will prevent a namespace destroy.
>
> Add resource end pnf in altmap and use that to check if the memmap area
> allocation can map pfn outside the namespace. On ppc64 in such case we fallback
> to allocation from memory.
>
> This fix kernel crash reported below:
>
> [  132.034989] WARNING: CPU: 13 PID: 13719 at mm/memremap.c:133 devm_memremap_pages_release+0x2d8/0x2e0
> [  133.464754] BUG: Unable to handle kernel data access at 0xc00c00010b204000
> [  133.464760] Faulting instruction address: 0xc00000000007580c
> [  133.464766] Oops: Kernel access of bad area, sig: 11 [#1]
> [  133.464771] LE PAGE_SIZE=64K MMU=Hash SMP NR_CPUS=2048 NUMA pSeries
> .....
> [  133.464901] NIP [c00000000007580c] vmemmap_free+0x2ac/0x3d0
> [  133.464906] LR [c0000000000757f8] vmemmap_free+0x298/0x3d0
> [  133.464910] Call Trace:
> [  133.464914] [c000007cbfd0f7b0] [c0000000000757f8] vmemmap_free+0x298/0x3d0 (unreliable)
> [  133.464921] [c000007cbfd0f8d0] [c000000000370a44] section_deactivate+0x1a4/0x240
> [  133.464928] [c000007cbfd0f980] [c000000000386270] __remove_pages+0x3a0/0x590
> [  133.464935] [c000007cbfd0fa50] [c000000000074158] arch_remove_memory+0x88/0x160
> [  133.464942] [c000007cbfd0fae0] [c0000000003be8c0] devm_memremap_pages_release+0x150/0x2e0
> [  133.464949] [c000007cbfd0fb70] [c000000000738ea0] devm_action_release+0x30/0x50
> [  133.464955] [c000007cbfd0fb90] [c00000000073a5a4] release_nodes+0x344/0x400
> [  133.464961] [c000007cbfd0fc40] [c00000000073378c] device_release_driver_internal+0x15c/0x250
> [  133.464968] [c000007cbfd0fc80] [c00000000072fd14] unbind_store+0x104/0x110
> [  133.464973] [c000007cbfd0fcd0] [c00000000072ee24] drv_attr_store+0x44/0x70
> [  133.464981] [c000007cbfd0fcf0] [c0000000004a32bc] sysfs_kf_write+0x6c/0xa0
> [  133.464987] [c000007cbfd0fd10] [c0000000004a1dfc] kernfs_fop_write+0x17c/0x250
> [  133.464993] [c000007cbfd0fd60] [c0000000003c348c] __vfs_write+0x3c/0x70
> [  133.464999] [c000007cbfd0fd80] [c0000000003c75d0] vfs_write+0xd0/0x250

Question, does this crash only happen when the namespace is not 16MB
aligned? In other words was this bug exposed by the subsection-hotplug
changes and should it contain Fixes: tag for those commits?
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
