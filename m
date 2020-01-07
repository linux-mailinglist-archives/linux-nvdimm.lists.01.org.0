Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3936133782
	for <lists+linux-nvdimm@lfdr.de>; Wed,  8 Jan 2020 00:39:11 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 02C4F10097E17;
	Tue,  7 Jan 2020 15:42:29 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::343; helo=mail-ot1-x343.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 1A63B10097E13
	for <linux-nvdimm@lists.01.org>; Tue,  7 Jan 2020 15:42:25 -0800 (PST)
Received: by mail-ot1-x343.google.com with SMTP id r27so1776072otc.8
        for <linux-nvdimm@lists.01.org>; Tue, 07 Jan 2020 15:39:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xMZkcHtFGlxtWMU0/yJi4CuOWPo2x4C+GD+Xd4ftxtY=;
        b=fGlV4Pr2MgSNzKMiDvbbOE+RWBOvNONUJBDPutDXvnKV0UHzXrxqy41oXKo6WrCibz
         nIRkrfWVWS/3omjTf2Szli0DI/W6lLwbaiIUY2Th1bSJbzbi5GX640rH874VzisnSJBN
         s3Goe8kx/MBl1KrfR/Q6Q38YPMR41UmkrW1Gd+X9IIEIxtYmHbhTJRqiFPcX8Z4JUIxo
         AbpigFkKiQOO5NhcIFROnexkKOwsN9Kh7HoEvk2zwnpTt8e9OmkfedzdRR1luOdVBsXq
         wj40LOEnqORt9GMjzv6fUO3xLP+gEY5sn5TmCNDBD42EaYbFnVTfd41qJspyjppYb7f8
         ISzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xMZkcHtFGlxtWMU0/yJi4CuOWPo2x4C+GD+Xd4ftxtY=;
        b=kUptnIl0Nj3LmidzdA+lAUMtvhNAAF5HRwowAnoIWg76XbF6ZNyaLZrpoSG5jAMPyN
         nco99bhaGCpQOTPngMe7mBrTKuvjshqn7n9fscQJekNaXi4YlfOmYo1Q4pmObB4WZm+j
         oqdfOrTG+O+mbG66LYpFhrhCg2IRQQTK2QuQX0bnBd+ipA/7+H6S9v4fZ+CLDFlloib5
         bIuNcW+c8ws5xgN5DwFWXVpWBx32JgX7HGd8SrER/OJVg40eYjhhstgqV072s5pddNJv
         UpAXHLPOU2pS5v87lX4pzcsnFRN7f1gOQa0DQj9SUfL/vsBQvX3dLGfHUbtpp8wN9897
         zkrg==
X-Gm-Message-State: APjAAAWH0im+6B0eiU+ohwJMJXkXrIMSBagfSZq/kDIIQqpQy70Wym2n
	ZvBUkK2ymhJjz6/alLpUuJnHicp84ISVLsBxm5vH3g==
X-Google-Smtp-Source: APXvYqzvMVVYbs2feLkPKE0gtd4wuHz+YTqavAMbyJigJXY55hh1AQBdpn4tA6LqJn24ZzdQ5nOCMzZ/4ozWhNizGXo=
X-Received: by 2002:a9d:68d3:: with SMTP id i19mr1958301oto.71.1578440345524;
 Tue, 07 Jan 2020 15:39:05 -0800 (PST)
MIME-Version: 1.0
References: <CAPcyv4jGEAbYSJef2zLzgg6Arozsuz7eN_vZL1iTcd1XQuNT4Q@mail.gmail.com>
 <20191216181014.GA30106@redhat.com> <20200107125159.GA15745@infradead.org>
 <CAPcyv4jZE35sbDo6J4ihioEUFTuekJ3_h0=2Ra4PY+xn2xn1cQ@mail.gmail.com>
 <20200107170731.GA472641@magnolia> <CAPcyv4ggH7-QhYg+YOOWn_m25uds+-0L46=N09ap-LALeGuU_A@mail.gmail.com>
 <20200107180101.GC15920@redhat.com> <CAPcyv4gmdoqpwwwy4dS3D2eZFjmJ_Zi39k=1a4wn-_ksm-UV4A@mail.gmail.com>
 <20200107183307.GD15920@redhat.com> <CAPcyv4ggoS4dWjq-1KbcuaDtroHKEi5Vu19ggJ-qgycs6w1eCA@mail.gmail.com>
 <20200107190258.GB472665@magnolia> <CAPcyv4ia9r0rdbb7t0JvEnGW6nnHdAWUHbaMrY5FKBY+4Fum6Q@mail.gmail.com>
In-Reply-To: <CAPcyv4ia9r0rdbb7t0JvEnGW6nnHdAWUHbaMrY5FKBY+4Fum6Q@mail.gmail.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Tue, 7 Jan 2020 15:38:54 -0800
Message-ID: <CAPcyv4jDYUPp=aqH1VTfxFAXiMa0Uqn+ykptfu_yNDOjR7Akfg@mail.gmail.com>
Subject: Re: [PATCH 01/19] dax: remove block device dependencies
To: "Darrick J. Wong" <darrick.wong@oracle.com>
Message-ID-Hash: T2LO5K6QTI22CPLDMMQ77ICUNQXURBGN
X-Message-ID-Hash: T2LO5K6QTI22CPLDMMQ77ICUNQXURBGN
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Christoph Hellwig <hch@infradead.org>, Dave Chinner <david@fromorbit.com>, Miklos Szeredi <miklos@szeredi.hu>, linux-nvdimm <linux-nvdimm@lists.01.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, virtio-fs@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>, linux-fsdevel <linux-fsdevel@vger.kernel.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/T2LO5K6QTI22CPLDMMQ77ICUNQXURBGN/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Jan 7, 2020 at 11:46 AM Dan Williams <dan.j.williams@intel.com> wrote:
[..]
> > I'd say deprecate the
> > kernel automounting partitions, but I guess it already does that, and
>
> Ok, now I don't know why automounting is leaking into this discussion?
>
> > removing it would break /something/.
>
> Yes, the breakage risk is anyone that was using ext4 mount failure as
> a dax capability detector.
>
> > I guess you could put
> > "/dev/pmemXpY" on the deprecation schedule.
>
> ...but why deprecate /dev/pmemXpY partitions altogether? If someone
> doesn't care about dax then they can do all the legacy block things.
> If they do care about dax then work with whole device namespaces.

Circling back on this point now that I understand what you meant by
automount. It would need to be a full deprecation of /dev/pmemXpY
devices if kpartx dax support is going to fully take over for people
that want to use disk partition tables instead of EFI Namespace Labels
to carve up pmem.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
