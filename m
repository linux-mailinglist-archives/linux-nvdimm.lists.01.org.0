Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BA73F1CE2EC
	for <lists+linux-nvdimm@lfdr.de>; Mon, 11 May 2020 20:39:02 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 0F539119D4576;
	Mon, 11 May 2020 11:36:35 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::542; helo=mail-ed1-x542.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 5E78A119C76B3
	for <linux-nvdimm@lists.01.org>; Mon, 11 May 2020 11:36:33 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id g16so8887700eds.1
        for <linux-nvdimm@lists.01.org>; Mon, 11 May 2020 11:38:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=53IaTZVnkO33jMVTypFlnVLWgmTqf93m7a9Flcs7Rks=;
        b=QPXuBQM/ZunMO+srtFoTr02of+FPo8BoBjz1V0zRqH1ZilVocQ5X4Ab36Zm98RZfmu
         aR3nMTv+nS5tYMiERkPYtkAgPzloJMuPGXXsNMJK3eVKPHLV0uykN1lAnVtPXwKxVD+3
         4qYufVr9QVhLLZyZVN+55XtBDela0jrMZqU2fYTWsiQgycehQeWjUkC4RFYmp8wIO5Ee
         e0+qYe0bMy73tVkVcBdNydCmlvtf/teK6K7xYgoMIeRW/+qzad6tk/hAXbQdTO7+AvSS
         4Gr5BtLr1vYb9ClBS38rqtbdlsUAtSzRh70EwdgjIO14DOAWihF1xNzBx7lffwCeG2f2
         dfcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=53IaTZVnkO33jMVTypFlnVLWgmTqf93m7a9Flcs7Rks=;
        b=U8Od8YungbxY6P1pJ3VavTArfIKoSOSj6Ac1niOI1KYwNBAVhxyazZmu1Ul0hQM25q
         jqEGs1SInlM5MKe2GuKgH76jaAU0VNKb/nh4c5z0DAZ55lCTiKHSZP25QM+hZWVHdDlz
         fo3YErD34EevaceB9wX0j6F02ijdrpbDyYJt+Vvrd1SKAOZGJhzeV6yKihRYqIRkVUKz
         N2/uys66+ghe39ooC4ydS87w/z0vKgn9GORaTzfPXcrfCtuJrd3dB7Js28d7Ypl1/ZER
         dZhvb7eYPZW3cQaoEh3HACEPPdjhVEwC5c06oq8lzS5SnV8y538VkcyCxb+AC/dr4WPO
         ulug==
X-Gm-Message-State: AGi0PuZZyCzjUnVJXE97AAATh8ZL/OcoVBhJxUduc5X19M4hRWMJbeKP
	bXbKsWb8/9czlYqPnV2c7IJTjrfsrOL2RPQmgcnTWA==
X-Google-Smtp-Source: APiQypIAa4pzr7LT5e143Un+Yy9rbFMWn7w5IV015KFJ1e09Kgv43a4k0POt9py7TuQC3xRGDzCg6bog/rhw833TML8=
X-Received: by 2002:a05:6402:3136:: with SMTP id dd22mr14384544edb.165.1589222336534;
 Mon, 11 May 2020 11:38:56 -0700 (PDT)
MIME-Version: 1.0
References: <20200511015404.GA1490816@mit.edu>
In-Reply-To: <20200511015404.GA1490816@mit.edu>
From: Dan Williams <dan.j.williams@intel.com>
Date: Mon, 11 May 2020 11:38:45 -0700
Message-ID: <CAPcyv4gotnFKCw8+p+DbT30E7eEix3mDkCbHJz9BA4DfeJOKig@mail.gmail.com>
Subject: Re: How to fake a dax device for debugging purposes?
To: "Theodore Y. Ts'o" <tytso@mit.edu>
Message-ID-Hash: ELKEHZAE7OPMU4PQZR5BA3H3I4VVYZHA
X-Message-ID-Hash: ELKEHZAE7OPMU4PQZR5BA3H3I4VVYZHA
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-nvdimm <linux-nvdimm@lists.01.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/ELKEHZAE7OPMU4PQZR5BA3H3I4VVYZHA/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Sun, May 10, 2020 at 6:54 PM Theodore Y. Ts'o <tytso@mit.edu> wrote:
>
> (Please keep me on the cc line since I'm not okn the linux-nvdimm list.)
>
> Hi,
>
> I used to fake up a dax-capable device for debugging ext4 by using
> instructions similar to the ones that can be found here:
>
> https://docs.pmem.io/persistent-memory/getting-started-guide/creating-development-environments/linux-environments/linux-memmap
>
> The problem is that with more recent kernels, this is no longer
> working for me.
>
> Here are the relevant dmesg lines (from running "gce-xfstests -c dax
> launch"):
>
> [    0.000000] Linux version 5.7.0-rc4-xfstests-00002-g8867a85a3164-dirty (tytso@lambda) (gcc version 9.3.0 (Debian 9.3.0-11), GNU ld (GNU Binutils for Debian) 2.34) #1692 SMP Sun May 10 21:21:14 EDT 2020
> [    0.000000] Command line: root=/dev/sda1 ro console=ttyS0,38400n8 elevator=noop net.ifnames=0 biosdevname=0 console=ttyS0 memmap=4G!9G memmap=9G!14G cmd=maint mem=26624M fstestcfg= fstestset= fstestexc= fstestopt= fstesttyp=ext4 fstestapi=1.5 fsteststr= nfssrv=
>        ...
> [    0.000000] user: [mem 0x0000000240000000-0x000000033fffffff] persistent (type 12)
> [    0.000000] user: [mem 0x0000000340000000-0x000000037fffffff] usable
> [    0.000000] user: [mem 0x0000000380000000-0x00000005bfffffff] persistent (type 12)
> [    0.000000] user: [mem 0x00000005c0000000-0x000000067fffffff] usable
>     ....
> [    3.180904] nd_pmem namespace0.0: unable to guarantee persistence of writes
> [    3.181750] nd_pmem namespace1.0: unable to guarantee persistence of writes
> [    3.188025] pmem0: detected capacity change from 0 to 4294967296
> [    3.189896] pmem1: detected capacity change from 0 to 9663676416
>
> But when I try to mount a file system with: "mount -o dax -t ext4 /dev/pmem0 /mnt" I get:
>
> [  168.136331] EXT4-fs (pmem0): DAX unsupported by block device.
>
> Looking at drivers/dax/super.c, and changing a bunch of pr_debug to
> pr_err, I found the following had triggered.
>
> [  168.130603] pmem0: error: request queue doesn't support dax
>
> So looks like drivers/nvdimm/pmem.c is failing to set QUEUE_FLAG_DAX
> flag on its queue, and so in turn that's because pmem->pfn_flags
> doesn't have PFN_MAP set.   And.... at that point, I'm lost.
>
> How do I make a /dev/pmem0 via the memmap= boot command line options
> be mountable as a dax mount file system?

Might you have disabled CONFIG_ZONE_DEVICE? That allows the pmem
driver to map 'struct page' for pmem and is required for DAX.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
