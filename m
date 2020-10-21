Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DF932951C3
	for <lists+linux-nvdimm@lfdr.de>; Wed, 21 Oct 2020 19:48:42 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 8AB88160892E8;
	Wed, 21 Oct 2020 10:48:40 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::541; helo=mail-ed1-x541.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 9988815F1674D
	for <linux-nvdimm@lists.01.org>; Wed, 21 Oct 2020 10:48:37 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id dg9so3404843edb.12
        for <linux-nvdimm@lists.01.org>; Wed, 21 Oct 2020 10:48:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wz+eFQ9E3XaBY60yIiY6/7ACNu1JGiJC/eGXK+f1jPc=;
        b=DVzkzBJthtEEE9BytDByy1Zyi6AvIrMMfqilJKnpXorOKZpcoMkmRc0+51O1rnlt68
         bMY0od0cPkgr22Fq/K+EKbRk9QUUZlKvr9mGhIHdkRS+RFdmguKEoaDMpwVT2MTekysU
         aICew+9IVF+RRyoiu/PaGJVFHpxpM2ZfnviDOpSraD9hqMuMque7/usM9pzF/eaK9iyi
         qZF3JdUTjmf2nLs5oVUYf43A1aDD3wYoYI9oxDRZY55ia14p0XqJNtzi/CDl0A92VIsH
         Ytn7i5HZw9HsfFtKjUgs2Sf+IlYn4ti3aGTMDIrNugvXoKAtZI0M50rVaCu67NNkO/yB
         jfiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wz+eFQ9E3XaBY60yIiY6/7ACNu1JGiJC/eGXK+f1jPc=;
        b=HcY4yaNj37RIZXA728Cps7kmt0/2zgziAWVMo4JpfnSFu1q3XY0bj6MPRDhaMEgXhE
         yuQdwNQMu8QxLyiY1emDxeUIEzZW77a3hJ3wZzY+6Lr1EbLZf0XgPo5umvd5LTCjBXK2
         TaON8TFzlu9x04YmI4OqCbJM0Q/JhMYwDw6lK2GXqDrQqz2o2i0MxoG5uqCZESWp0Vzd
         XQnSVW0nohvub6XEMRMiJGpz5pspkJBEPxjrEwfzxA02NfP0MwjB5KYgTbhlNtKUB7j6
         2aDwliK0k+aBzIOuKALI1CNxC4BjJwSm9DezVvbsDAlmT+FJbdqXW22BzS87AWINDKI2
         pL4g==
X-Gm-Message-State: AOAM5327hR0ZXsPEYG8BEekR59DiyhxwO02xyVMkeX291Ev4SD1/uEwX
	MzSUxBxoadaHo7WxZsxG0p0tAt+WXFSkDQgth4NtvA==
X-Google-Smtp-Source: ABdhPJyjfO8m3iOuqLFtlf+FomXd1BC4F7cQcApVrqZXlZQ1jUukEoyZcjOKoq++KT+r97hpdUtXqWK1yOAZ0wQ8O8o=
X-Received: by 2002:a05:6402:31b3:: with SMTP id dj19mr4292662edb.210.1603302515911;
 Wed, 21 Oct 2020 10:48:35 -0700 (PDT)
MIME-Version: 1.0
References: <20201012162736.65241-1-nmeeramohide@micron.com>
 <20201015080254.GA31136@infradead.org> <SN6PR08MB420880574E0705BBC80EC1A3B3030@SN6PR08MB4208.namprd08.prod.outlook.com>
 <CAPcyv4j7a0gq++rL--2W33fL4+S0asYjYkvfBfs+hY+3J=c_GA@mail.gmail.com>
 <SN6PR08MB420843C280D54D7B5B76EB78B31E0@SN6PR08MB4208.namprd08.prod.outlook.com>
 <CAPcyv4iYOk3i0pPgXxDTy47BxWCXqqXS0J6mrY5o+1M_41XoAw@mail.gmail.com> <SN6PR08MB4208A22F5C94AB05439A2703B31C0@SN6PR08MB4208.namprd08.prod.outlook.com>
In-Reply-To: <SN6PR08MB4208A22F5C94AB05439A2703B31C0@SN6PR08MB4208.namprd08.prod.outlook.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Wed, 21 Oct 2020 10:48:24 -0700
Message-ID: <CAPcyv4gOGi392Q3knF=cAuvKONnmp2AoKX82VQEQJU0c7o7AKA@mail.gmail.com>
Subject: Re: [EXT] Re: [PATCH v2 00/22] add Object Storage Media Pool (mpool)
To: "Nabeel Meeramohideen Mohamed (nmeeramohide)" <nmeeramohide@micron.com>
Message-ID-Hash: TZXGWPGEZCGMPOKE3QF3GKRYLLSURDUS
X-Message-ID-Hash: TZXGWPGEZCGMPOKE3QF3GKRYLLSURDUS
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Christoph Hellwig <hch@infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>, "Steve Moyer (smoyer)" <smoyer@micron.com>, "Greg Becker (gbecker)" <gbecker@micron.com>, "Pierre Labat (plabat)" <plabat@micron.com>, "John Groves (jgroves)" <jgroves@micron.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/TZXGWPGEZCGMPOKE3QF3GKRYLLSURDUS/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Oct 21, 2020 at 10:11 AM Nabeel Meeramohideen Mohamed
(nmeeramohide) <nmeeramohide@micron.com> wrote:
>
> On Tuesday, October 20, 2020 3:36 PM, Dan Williams <dan.j.williams@intel.com> wrote:
> >
> >     What does Linux get from merging mpool?
> >
>
> What Linux gets from merging mpool is a generic object store target with some
> unique and beneficial features:

I'll try to make the point a different way. Mpool points out places
where the existing apis fail to scale. Rather than attempt to fix that
problem it proposes to replace the old apis. However, the old apis are
still there. So now upstream has 2 maintenance burdens when it could
have just had one. So when I ask "what does Linux get" it is in
reference to the fact that Linux gets a compounded maintenance problem
and whether the benefits of mpool outweigh that burden. Historically
Linux has been able to evolve to meet the scaling requirements of new
applications, so I am asking whether you have tried to solve the
application problem by evolving rather than replacing existing
infrastructure? The justification to replace rather than evolve is
high because that's how core Linux stays relevant.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
