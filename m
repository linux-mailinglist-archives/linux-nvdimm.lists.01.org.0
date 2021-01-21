Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BBD82FF144
	for <lists+linux-nvdimm@lfdr.de>; Thu, 21 Jan 2021 18:03:08 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id BE4E6100EB820;
	Thu, 21 Jan 2021 09:03:05 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::531; helo=mail-ed1-x531.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id D768B100ED4AC
	for <linux-nvdimm@lists.01.org>; Thu, 21 Jan 2021 09:03:01 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id h16so3333635edt.7
        for <linux-nvdimm@lists.01.org>; Thu, 21 Jan 2021 09:03:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=w+TZZsn+eqR6dTUulMdxx7PCbvr89MO/4XGUQAazVhU=;
        b=qgklzAjQOOZAhjLACjNI3HGCva6Z/AY6d3/GYc5AKCflwmduNLQhSv2QoGHQJoNgnl
         K8u6tzI7b8rumOkz5fPTSocWVkUsUBnPZi7aW1L4sfXlZhGcpch5Fwo3UknfdKxtMJkR
         M+06MHL7ItA+S4Y+iigUH4JZ8V7YR0J0Po0vEsBFysyNKISgY+HGX+9ciC1mt6Z7iUNs
         mSLj+D0iDiPcPl633WbP75IdxPQD7UDulesSYJ05L3JXRotfL3y732JvVIYenpGnH7jB
         BhhQzOoONYtyA4jXFAzkchZFRdO4Mp89gj/5nQAWYZGybz1Wju3o43o/gdCNhSToy2NO
         2AaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=w+TZZsn+eqR6dTUulMdxx7PCbvr89MO/4XGUQAazVhU=;
        b=ZLxO07+4FtUPtfkMifGThYQjUhxhgdlN5/wI+kW4cFIUqzVuNKbwJACqrj2H1wDQ3j
         +x5N9YRB7nWLRngIJEVb7BdUaVcHxPVl4oRrN4YCDDQGPSSz0zF+yj7iJCWnuRkScqRP
         1RpqUlOGUymyXCXb6qJNXXNt8eDpAVydDgQocfY8+iQhB2W3r0wNT7VLAY2GivwMnThf
         XlctClEkzVB5aO/k1QOHSjYZ8c7lnXZZK1lNLx2bqYaKzSlhfSI64cTXCiW+P6T5JpI9
         ICxB5yBWTMPbLMtkbFrVCOKzagE3IPqI+k941S1QiHE+0LZ9iFiIT69cOnqIMVp5lYjN
         FjdA==
X-Gm-Message-State: AOAM531bEmVG5ePKfcFiwYMpJwTo/fGoAF3jyK2BZpCTpkbFQK4VOg3v
	8F4Iy1pVkv/m9wZ+330FG4lu580Snk5B5+roL+1N0w==
X-Google-Smtp-Source: ABdhPJzJLLvdtRLueXSdnMYSOmghDAPfUSB4ghbCw5HZxdtuI7Z5ogkE5CUxZQGuTLW2XdyrO5QxRQGuAFGehCsiW/k=
X-Received: by 2002:aa7:d610:: with SMTP id c16mr72438edr.354.1611248579079;
 Thu, 21 Jan 2021 09:02:59 -0800 (PST)
MIME-Version: 1.0
References: <161117153248.2853729.2452425259045172318.stgit@dwillia2-desk3.amr.corp.intel.com>
 <161117154856.2853729.1012816981381380656.stgit@dwillia2-desk3.amr.corp.intel.com>
 <YAk4MMMmmbKe6XEQ@kroah.com>
In-Reply-To: <YAk4MMMmmbKe6XEQ@kroah.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Thu, 21 Jan 2021 09:02:53 -0800
Message-ID: <CAPcyv4h74NjqcuUjv4zFKHAxio_bV0bngLoxP=ACw=JvMfq-UA@mail.gmail.com>
Subject: Re: [PATCH 3/3] libnvdimm/ioctl: Switch to cdev_register_queued()
To: Greg KH <gregkh@linuxfoundation.org>
Message-ID-Hash: 7E4UY2RVUH7W57IYTFSDUU7NEZIYK7MJ
X-Message-ID-Hash: 7E4UY2RVUH7W57IYTFSDUU7NEZIYK7MJ
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Logan Gunthorpe <logang@deltatee.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-nvdimm <linux-nvdimm@lists.01.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/7E4UY2RVUH7W57IYTFSDUU7NEZIYK7MJ/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, Jan 21, 2021 at 12:16 AM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Wed, Jan 20, 2021 at 11:39:08AM -0800, Dan Williams wrote:
> > The ioctl implementation in libnvdimm is a case study in what can be
> > cleaned up when the cdev core handles synchronizing in-flight ioctls
> > with device removal. Switch to cdev_register_queued() which allows for
> > the ugly context lookup and activity tracking implementation to be
> > dropped, among other cleanups.
>
> I'm confused, the cdev handles the filesystem access from /dev/ which
> handles the ioctl.  Any use of a cdev with relationship to a struct
> device that might go away is independent, so we really should not tie
> these together in any way.

Oh, no, there's no object lifetime ties here, that problem was already
solved with Logan's addition of cdev_device_add(). Instead, this about
file_operations liveness. Look at procfs and debugfs that Christoph
pointed out have open coded the same facility. When the driver is
unbound ongoing file operations should be flushed and blocked
currently the cdev api is forcing every driver to open code this
themselves.

This seems a pattern that is asking to be unified as a general
"managed fops" concept.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
