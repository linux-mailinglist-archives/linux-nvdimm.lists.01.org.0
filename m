Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2542A155C3C
	for <lists+linux-nvdimm@lfdr.de>; Fri,  7 Feb 2020 17:57:55 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 38AC110FC3584;
	Fri,  7 Feb 2020 09:01:11 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::342; helo=mail-ot1-x342.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 6CAF910FC3583
	for <linux-nvdimm@lists.01.org>; Fri,  7 Feb 2020 09:01:08 -0800 (PST)
Received: by mail-ot1-x342.google.com with SMTP id d3so2793868otp.4
        for <linux-nvdimm@lists.01.org>; Fri, 07 Feb 2020 08:57:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DoXHMrXc9C3nIDwMKcXgxUp8VuOy5v934gcrKt8olSo=;
        b=sliBWNmuOcp/8Onk/Da5rXzPxsGMzcyjLeyWKLOvl+uXkXIsW1atOmc8S7ciDDOBCJ
         oUKpU53yvCMSBda+W0UY82HP49IXpmYy9HPEypnAnFz82TjvsEa/mpJG6MaIM5VylaRe
         v4D3JkKuFFsMb9etnbhcGKCMyq4ixze7qkLQ/POSSxAQ3sIJ4baIbU5IoE1qqZRa6ksx
         DvqvCRA0JoyDJ2loFtWunMfX187kkf3BFfANnr7bk+GrVN5eUl8FsYlQGkS5KlPFNoov
         n6cxTQSKg63cRaAeje7AuDS/GxqXjcBnprMjexZb2CK0h9IBLcE2pYojXYmZs+aN9ZBn
         mPYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DoXHMrXc9C3nIDwMKcXgxUp8VuOy5v934gcrKt8olSo=;
        b=Akt9eGD0xbGKAeM2CMsdlM+g3qkuYRGIHd3QHciVYwSvv8l3rRFdnejNMHTlR7ONiX
         r/UtRfMGPFH3+8DLn6jgusYafwFm5q66THezj4h/6/1ORdAClSxF7xTq6ECfUfS9qEyF
         66RV9LzdVG6rptIBxchE5uhSaM/SFo8uPtAHL1MA4aNGiKQRb7UUC1aCS1oKIM90lGBo
         hWjBkmsdH+utlP8ZGzF9mfGqRoHJE+D7KeTwAXGUqFqnhBYz08ez+q4Xm5W5HY08RaXF
         KX+t6axFcXCzWjwH4jps0eS2ExrlvQNnrOfj8EB2cU1Ook5Q53oh20gBrFolzGgeX00M
         MIPQ==
X-Gm-Message-State: APjAAAWfVroypzJGcwra3GJp9+X8rkdNXXvfPCfJVYK3xMHBye14G0YV
	viJ3OiEUlRm9c1fELRo8vRXqpj1cDAJB3ON9fsS5Iw==
X-Google-Smtp-Source: APXvYqwZEd2ifdEG5DmRy5nKYxx/U0RJ8V18sdsJ2ufK7/ON2ZEyKZ8XWshkO52/AgDVnNwawXJ5TiRbMjZ0ofXEOh4=
X-Received: by 2002:a9d:64d8:: with SMTP id n24mr215119otl.71.1581094670173;
 Fri, 07 Feb 2020 08:57:50 -0800 (PST)
MIME-Version: 1.0
References: <20200203200029.4592-1-vgoyal@redhat.com> <20200203200029.4592-2-vgoyal@redhat.com>
 <20200205183050.GA26711@infradead.org> <20200205200259.GE14544@redhat.com>
 <CAPcyv4iY=gw86UDLqpiCtathGXRUuxOMuU=unwxzA-cm=0x+Sg@mail.gmail.com> <20200206074142.GB28365@infradead.org>
In-Reply-To: <20200206074142.GB28365@infradead.org>
From: Dan Williams <dan.j.williams@intel.com>
Date: Fri, 7 Feb 2020 08:57:39 -0800
Message-ID: <CAPcyv4iTBTOuKjQX3eoojLM=Eai_pfARXmzpMAtgi5OWBHXvzQ@mail.gmail.com>
Subject: Re: [PATCH 1/5] dax, pmem: Add a dax operation zero_page_range
To: Christoph Hellwig <hch@infradead.org>
Message-ID-Hash: MN7O75JZWPWY6DAWXVSLNYOFBUIDSXLQ
X-Message-ID-Hash: MN7O75JZWPWY6DAWXVSLNYOFBUIDSXLQ
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-fsdevel <linux-fsdevel@vger.kernel.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, device-mapper development <dm-devel@redhat.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/MN7O75JZWPWY6DAWXVSLNYOFBUIDSXLQ/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Feb 5, 2020 at 11:41 PM Christoph Hellwig <hch@infradead.org> wrote:
>
> On Wed, Feb 05, 2020 at 04:40:44PM -0800, Dan Williams wrote:
> > > I don't have any reason not to pass phys_addr_t. If that sounds better,
> > > will make changes.
> >
> > The problem is device-mapper. That wants to use offset to route
> > through the map to the leaf device. If it weren't for the firmware
> > communication requirement you could do:
> >
> > dax_direct_access(...)
> > generic_dax_zero_page_range(...)
> >
> > ...but as long as the firmware error clearing path is required I think
> > we need to do pass the pgoff through the interface and do the pgoff to
> > virt / phys translation inside the ops handler.
>
> Maybe phys_addr_t was the wrong type - but why do we split the offset
> into the block device argument into a pgoff and offset into page instead
> of a single 64-bit value?

Oh, got it yes, that looks odd for sub-page zeroing. Yes, let's just
have one device relative byte-offset.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
