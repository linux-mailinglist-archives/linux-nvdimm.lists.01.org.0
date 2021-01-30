Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50686309169
	for <lists+linux-nvdimm@lfdr.de>; Sat, 30 Jan 2021 02:59:35 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 67AC7100EC1D8;
	Fri, 29 Jan 2021 17:59:33 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::633; helo=mail-ej1-x633.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id A9130100ED48C
	for <linux-nvdimm@lists.01.org>; Fri, 29 Jan 2021 17:59:28 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id hs11so15656231ejc.1
        for <linux-nvdimm@lists.01.org>; Fri, 29 Jan 2021 17:59:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EWo4KjlIrzjbnoyurSSBVNGq8JCtPRxkHzDKnUW80j0=;
        b=P858ojYjTMLet0tza2ROjVLugxIkJKWKScHcI99wlUNAmdxT/q0A+8k3B4mv69C6zW
         pZ3i9rKjIGm6RktXcFu6kGETkt4+Jprl742+JAq4QxjvLpmTtFhN3miGluA4/V/VKeJv
         9nZml1zipllmwJKOv8oSAuBaFNUHz9Rl4zI9JcuPjIHxoW3Bl2UIz3T7v/Mhw5V6YC6F
         XVFOnWy13TgIeKZ9JZEcevyMlunFbyxb2gWPKmVAZuGq6Nh186yBr2KUEe4zNweU597Q
         J2WEvdpkdziTYPjCr6ZlwS9Ei/JRG+DNDI+wOaCr7qodi4DudmJQBCv2t/yAQ5R6U3fT
         df+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EWo4KjlIrzjbnoyurSSBVNGq8JCtPRxkHzDKnUW80j0=;
        b=BuOVB9RrGrVbqC16FvEWnfod5CihmKt6s8EfFEay776MGfpzrdHMhRP0NXPi/JCFHE
         0fCjwcJNE0qGysJPljsv4sxA4Ew7Qg/Tw3lyHpLWjSVNQBRXRNUsJuOQLW/yv8IfAHb/
         gXfTtZdDp2w8K3+9M5tkKRWDTMsC3dl6XVaTXfNW1jqtSONQ2pUpyIOHfVN8DvaAADyc
         oRzmgmr+vPuUVkJRy3twYGmSuMSEvoLKYeR2s2yjwH06GknNSgxjIS+lKDRu9l/AoYfC
         TFdFTTwRlzzM4eIWDRKp9fZPpKa06HUW4TuZlUqvSNnoR1PEXmtNHWMsVC0ROR93mNPi
         36vw==
X-Gm-Message-State: AOAM5338sNFparwo2NHozoo+Zmes/Yd4y0OYtUJL9SKwLKoXd2f5GnPB
	iLsQiMOlirH/4/C+vkIYG+JJCMkk11Ou2epz5M1IKw==
X-Google-Smtp-Source: ABdhPJyteHUAK6EjHEtc9xneY7O6pvnG4P0dUDapv2YrqKHQ9TTcKg3Asw/O8AVJSbRScvPOSKnGqXrPFZiktJtSdM8=
X-Received: by 2002:a17:906:f919:: with SMTP id lc25mr7315521ejb.323.1611971966715;
 Fri, 29 Jan 2021 17:59:26 -0800 (PST)
MIME-Version: 1.0
References: <161117153248.2853729.2452425259045172318.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <161117153248.2853729.2452425259045172318.stgit@dwillia2-desk3.amr.corp.intel.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Fri, 29 Jan 2021 17:59:24 -0800
Message-ID: <CAPcyv4jEYPsyh0bhbtKGRbK3bgp=_+=2rjx4X0gLi5-25VvDyg@mail.gmail.com>
Subject: Re: [PATCH 0/3] cdev: Generic shutdown handling
To: Greg KH <gregkh@linuxfoundation.org>
Message-ID-Hash: 6RKXJZMBAG7QLTV27WSPJIWWO5VQKVWW
X-Message-ID-Hash: 6RKXJZMBAG7QLTV27WSPJIWWO5VQKVWW
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Alexandre Belloni <alexandre.belloni@free-electrons.com>, Alexander Viro <viro@zeniv.linux.org.uk>, Logan Gunthorpe <logang@deltatee.com>, Hans Verkuil <hans.verkuil@cisco.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-nvdimm <linux-nvdimm@lists.01.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/6RKXJZMBAG7QLTV27WSPJIWWO5VQKVWW/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Jan 20, 2021 at 11:38 AM Dan Williams <dan.j.williams@intel.com> wrote:
>
> After reviewing driver submissions with new cdev + ioctl usages one
> common stumbling block is coordinating the shutdown of the ioctl path,
> or other file operations, at driver ->remove() time. While cdev_del()
> guarantees that no new file descriptors will be established, operations
> on existing file descriptors can proceed indefinitely.
>
> Given the observation that the kernel spends the resources for a percpu_ref
> per request_queue shared with all block_devices on a gendisk, do the
> same for all the cdev instances that share the same
> cdev_add()-to-cdev_del() lifetime.
>
> With this in place cdev_del() not only guarantees 'no new opens', but it
> also guarantees 'no new operations invocations' and 'all threads running
> in an operation handler have exited that handler'.

Prompted by the reaction I realized that this is pushing an incomplete
story about why this is needed, and the "queued" concept is way off
base. The problem this is trying to solve is situations like this:

long xyz_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
{
        xyz_ioctl_dev = file->private_data;
        xyz_driver_context = xyz_ioctl_dev->context;
        ...
}

int xyz_probe(struct device *dev)
{
        xyz_driver_context = devm_kzalloc(...);
        ...
        xyz_ioctl_dev = kmalloc(...);
        device_initialize(&xyz_ioctl_dev->dev);
        xyz_ioctl_dev->context = xyz_driver_context;
      ...
        cdev_device_add(&xyz_ioctl_dev->cdev, xyz_ioctl_dev->dev);
}

...where a parent driver allocates context tied to the lifetime of the
parent device driver-bind-lifetime, and that context ends up getting
used in the ioctl path. I interpret Greg's assertion "if you do this
right you don't have this problem" as "don't reference anything with a
lifetime shorter than the xyz_ioctl_dev lifetime in your ioctl
handler". That is true, but it can be awkward to constraint
xyz_driver_context to a sub-device, and it constrains some of the
convenience of devm. So the goal is to have a cdev api that accounts
for all the common lifetimes when devm is in use. So I'm now thinking
of an api like:

    devm_cdev_device_add(struct device *host, struct cdev *cdev,
struct device *dev)

...where @host bounds the lifetime of data used by the cdev
file_operations, and @dev is the typical containing structure for
@cdev. Internally I would refactor the debugfs mechanism for flushing
in-flight file_operations so that is shared by the cdev
implementation. Either adopt the debugfs method for file_operations
syncing, or switch debugfs to percpu_ref (leaning towards the former).

Does this clarify the raised concerns?
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
