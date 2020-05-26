Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 978921E304C
	for <lists+linux-nvdimm@lfdr.de>; Tue, 26 May 2020 22:52:38 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 5656012233840;
	Tue, 26 May 2020 13:48:30 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::644; helo=mail-ej1-x644.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id ED85912227BD5
	for <linux-nvdimm@lists.01.org>; Tue, 26 May 2020 13:48:27 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id d7so25345949eja.7
        for <linux-nvdimm@lists.01.org>; Tue, 26 May 2020 13:52:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZL3ilne+GNMSewS9YNjjKuWKAhBcjlAa2MA8SA2wuzA=;
        b=r2z4N6y94qMDZmbC/5g8ZBnNI9jDMJ43mzIkUt4bZ7LmsB6zn5gkm7oPk75lZyCEtZ
         WjWwJXrH21yDNsQaRIfBLv83UxxAikddjQnOGHLgDlVQulNNWFzouNZndtKZjQKNS8Ot
         FgzwXg3SERr6wpTeOEynVkKst8khQJF3sPMQ25pJg0fVNjGxBOtnI/q6eEbjBFfHTZ4u
         c8OqeLgS05yVuUwUACTZXIzRAcp5wT65wNtQ6txdqdttRE59cQToUbGT0mqoEsTUvJ0t
         knaW1ecZpjF1p/s6HHOIyJx/lNj3usTQn6Q1WPAWGztLrAjKhJiv6JraLIoM+CaJXAbk
         ZhIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZL3ilne+GNMSewS9YNjjKuWKAhBcjlAa2MA8SA2wuzA=;
        b=sTmLBgeZTnLWXZRE4YvBFWe2OmjsZLxe0KCAqD4iTfIgmpaIgepXDG1PAgI+lTngEu
         3OSAdReX+KNNyNbHjBAx+WN5coKvfm01gl4fyxSM0qcLrfbKHMZzfsqccpg5ZrkhEmIH
         4bQj/AKsO5Ob5DBe/Q51xL1qdsTcLuaIK93VONvjyYa8RRAXN5GayaQR7kybidjre5lB
         p3p34XsPc72UVjLpdn9aUxe7AwdTj7P7bOVbFef3cOKmpQq+KtYPk7ECKh+c1/H8lwBA
         ah1Xfg4DYZydY03WIcvIv6Kvshlxcqt7LMf21bdQEkavrPZJv+zZClqAHXzjyjKesOTT
         +cEA==
X-Gm-Message-State: AOAM532KqvhfVQLEHfKYErjy8FjsKWMs+sAsyDTrXwoop74RT+JCEu8J
	gmF3IpCP6jbMS1CuADeM3YIL71RoObqv2/GzE3Mokg==
X-Google-Smtp-Source: ABdhPJwj5jKLXuQ67bNjPxeM/yLM9fMTV9PfxjjNpwwOPDOS4fyMuJll+S41uNZuvGe7j3DAA6kwNJejL2G57xt2xpk=
X-Received: by 2002:a17:906:3597:: with SMTP id o23mr2722884ejb.174.1590526352787;
 Tue, 26 May 2020 13:52:32 -0700 (PDT)
MIME-Version: 1.0
References: <159010426294.1062454.8853083370975871627.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20200522115800.GA1451824@kroah.com> <20200522120009.GA1456052@kroah.com>
 <CAPcyv4jW9P2FP2p6OiLoN+e_wzZY9-c8C-mMMoDqohuTekF7WQ@mail.gmail.com> <x491rn6a0bp.fsf@segfault.boston.devel.redhat.com>
In-Reply-To: <x491rn6a0bp.fsf@segfault.boston.devel.redhat.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Tue, 26 May 2020 13:52:21 -0700
Message-ID: <CAPcyv4idRgByUTdb=6coYV=kkhqfLTzO1c+LZc7VQXus-BHh6Q@mail.gmail.com>
Subject: Re: [5.4-stable PATCH 0/7] libnvdimm: Cross-arch compatible namespace alignment
To: Jeff Moyer <jmoyer@redhat.com>
Message-ID-Hash: RURMABNKWZMGWXV32JPOX3GSTKHCOELR
X-Message-ID-Hash: RURMABNKWZMGWXV32JPOX3GSTKHCOELR
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Greg KH <gregkh@linuxfoundation.org>, stable <stable@vger.kernel.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Michael Ellerman <mpe@ellerman.id.au>, Paul Mackerras <paulus@samba.org>, Christoph Hellwig <hch@lst.de>, "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, linux-nvdimm <linux-nvdimm@lists.01.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/RURMABNKWZMGWXV32JPOX3GSTKHCOELR/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, May 26, 2020 at 1:49 PM Jeff Moyer <jmoyer@redhat.com> wrote:
>
> Dan Williams <dan.j.williams@intel.com> writes:
>
> >> What problems with 5.4.y and 5.6.y is this series fixing
> >> that used to work before?
> >
> > The "used to work" bug fixed by this set is the fact that the kernel
> > used to force a 128MB (memory hotplug section size) alignment padding
> > on all persistent memory namespaces to enable DAX operation. The
> > support for sub-sections (2MB) dropped forced alignment padding, but
> > unfortunately introduced a regression for the case of trying to create
> > multiple unaligned namespaces. When that bug triggers namespace
> > creation for the region is disabled, iirc, previously that lockout
> > scenario was prevented.
> >
> > Jeff, can you corroborate this?
>
> So, I don't pretend to remember the exact state of brokenness for each
> iteration.  :)  As far as I can recall, though, the issue you describe
> with a misaligned namespace preventing further namespace creation was
> present in all kernels up until it was finally fixed.

Well, if it was always there, then there is nothing to fix, and I
misremembered that we went backwards.

> > I otherwise agree, if the above never worked then this can all wait
> > for v5.7 upgrades.
>
> I can test specific kernel versions if that would help out.

Thanks for that offer, but outside of a clear regression I don't think
this meets -stable criteria.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
