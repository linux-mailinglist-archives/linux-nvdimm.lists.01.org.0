Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88B8612600
	for <lists+linux-nvdimm@lfdr.de>; Fri,  3 May 2019 03:26:42 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id AEAD721244A0A;
	Thu,  2 May 2019 18:26:40 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=198.145.29.99; helo=mail.kernel.org; envelope-from=shuah@kernel.org;
 receiver=linux-nvdimm@lists.01.org 
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id EBAF121244A06
 for <linux-nvdimm@lists.01.org>; Thu,  2 May 2019 18:26:38 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net
 [24.9.64.241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id BD7F22075E;
 Fri,  3 May 2019 01:26:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1556846798;
 bh=ezIzjSzXH0XYlnG8MDnPY/5HL3hONlOSfYSFuod7JP4=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=dSKrZ0M3+KMtPQkDdumpJNz+AO6E8QIThgPYAO13XHWWwflaoRbIz/oNqlv7qoGTe
 VXl92EIa/rUgQudCogxHlCVDc61J3iy5Cvqxwo79kJh2ROhBpjJ7BSMqTUevaRDp6y
 lAlz7wW77WAmzYXCoP5yBl+76exX90pmOHxKFBS8=
Subject: Re: [PATCH v2 03/17] kunit: test: add string_stream a std::stream
 like string builder
To: Brendan Higgins <brendanhiggins@google.com>, frowand.list@gmail.com,
 gregkh@linuxfoundation.org, keescook@google.com,
 kieran.bingham@ideasonboard.com, mcgrof@kernel.org, robh@kernel.org,
 sboyd@kernel.org
References: <20190501230126.229218-1-brendanhiggins@google.com>
 <20190501230126.229218-4-brendanhiggins@google.com>
From: shuah <shuah@kernel.org>
Message-ID: <1befe456-d981-d726-44f9-ebe3702ee51d@kernel.org>
Date: Thu, 2 May 2019 19:26:35 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190501230126.229218-4-brendanhiggins@google.com>
Content-Language: en-US
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
Cc: pmladek@suse.com, linux-doc@vger.kernel.org, amir73il@gmail.com,
 dri-devel@lists.freedesktop.org, Alexander.Levin@microsoft.com,
 linux-kselftest@vger.kernel.org, linux-nvdimm@lists.01.org,
 khilman@baylibre.com, knut.omang@oracle.com, wfg@linux.intel.com,
 joel@jms.id.au, rientjes@google.com, jdike@addtoit.com,
 dan.carpenter@oracle.com, devicetree@vger.kernel.org,
 linux-kbuild@vger.kernel.org, Tim.Bird@sony.com, linux-um@lists.infradead.org,
 rostedt@goodmis.org, julia.lawall@lip6.fr, skhan@linuxfoundation.org,
 kunit-dev@googlegroups.com, richard@nod.at, linux-kernel@vger.kernel.org,
 daniel@ffwll.ch, mpe@ellerman.id.au, linux-fsdevel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On 5/1/19 5:01 PM, Brendan Higgins wrote:
> A number of test features need to do pretty complicated string printing
> where it may not be possible to rely on a single preallocated string
> with parameters.
> 
> So provide a library for constructing the string as you go similar to
> C++'s std::string.
> 
> Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> ---
>   include/kunit/string-stream.h |  51 ++++++++++++
>   kunit/Makefile                |   3 +-
>   kunit/string-stream.c         | 144 ++++++++++++++++++++++++++++++++++
>   3 files changed, 197 insertions(+), 1 deletion(-)
>   create mode 100644 include/kunit/string-stream.h
>   create mode 100644 kunit/string-stream.c
> 
> diff --git a/include/kunit/string-stream.h b/include/kunit/string-stream.h
> new file mode 100644
> index 0000000000000..567a4629406da
> --- /dev/null
> +++ b/include/kunit/string-stream.h
> @@ -0,0 +1,51 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * C++ stream style string builder used in KUnit for building messages.
> + *
> + * Copyright (C) 2019, Google LLC.
> + * Author: Brendan Higgins <brendanhiggins@google.com>
> + */
> +
> +#ifndef _KUNIT_STRING_STREAM_H
> +#define _KUNIT_STRING_STREAM_H
> +
> +#include <linux/types.h>
> +#include <linux/spinlock.h>
> +#include <linux/kref.h>
> +#include <stdarg.h>
> +
> +struct string_stream_fragment {
> +	struct list_head node;
> +	char *fragment;
> +};
> +
> +struct string_stream {
> +	size_t length;
> +	struct list_head fragments;
> +
> +	/* length and fragments are protected by this lock */
> +	spinlock_t lock;
> +	struct kref refcount;
> +};
> +
> +struct string_stream *new_string_stream(void);
> +
> +void destroy_string_stream(struct string_stream *stream);
> +
> +void string_stream_get(struct string_stream *stream);
> +
> +int string_stream_put(struct string_stream *stream);
> +
> +int string_stream_add(struct string_stream *this, const char *fmt, ...);
> +
> +int string_stream_vadd(struct string_stream *this,
> +		       const char *fmt,
> +		       va_list args);
> +
> +char *string_stream_get_string(struct string_stream *this);
> +
> +void string_stream_clear(struct string_stream *this);
> +
> +bool string_stream_is_empty(struct string_stream *this);
> +
> +#endif /* _KUNIT_STRING_STREAM_H */
> diff --git a/kunit/Makefile b/kunit/Makefile
> index 5efdc4dea2c08..275b565a0e81f 100644
> --- a/kunit/Makefile
> +++ b/kunit/Makefile
> @@ -1 +1,2 @@
> -obj-$(CONFIG_KUNIT) +=			test.o
> +obj-$(CONFIG_KUNIT) +=			test.o \
> +					string-stream.o
> diff --git a/kunit/string-stream.c b/kunit/string-stream.c
> new file mode 100644
> index 0000000000000..7018194ecf2fa
> --- /dev/null
> +++ b/kunit/string-stream.c
> @@ -0,0 +1,144 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * C++ stream style string builder used in KUnit for building messages.
> + *
> + * Copyright (C) 2019, Google LLC.
> + * Author: Brendan Higgins <brendanhiggins@google.com>
> + */
> +
> +#include <linux/list.h>
> +#include <linux/slab.h>
> +#include <kunit/string-stream.h>
> +
> +int string_stream_vadd(struct string_stream *this,
> +		       const char *fmt,
> +		       va_list args)
> +{
> +	struct string_stream_fragment *fragment;

Since there is field with the same name, please use a different
name. Using the same name for the struct which contains a field
of the same name get very confusing and will hard to maintain
the code.

> +	int len;
> +	va_list args_for_counting;
> +	unsigned long flags;
> +
> +	/* Make a copy because `vsnprintf` could change it */
> +	va_copy(args_for_counting, args);
> +
> +	/* Need space for null byte. */
> +	len = vsnprintf(NULL, 0, fmt, args_for_counting) + 1;
> +
> +	va_end(args_for_counting);
> +
> +	fragment = kmalloc(sizeof(*fragment), GFP_KERNEL);
> +	if (!fragment)
> +		return -ENOMEM;
> +
> +	fragment->fragment = kmalloc(len, GFP_KERNEL);

This is confusing. See above comment.


> +	if (!fragment->fragment) {
> +		kfree(fragment);
> +		return -ENOMEM;
> +	}
> +
> +	len = vsnprintf(fragment->fragment, len, fmt, args);
> +	spin_lock_irqsave(&this->lock, flags);
> +	this->length += len;
> +	list_add_tail(&fragment->node, &this->fragments);
> +	spin_unlock_irqrestore(&this->lock, flags);
> +	return 0;
> +}
> +
> +int string_stream_add(struct string_stream *this, const char *fmt, ...)
> +{
> +	va_list args;
> +	int result;
> +
> +	va_start(args, fmt);
> +	result = string_stream_vadd(this, fmt, args);
> +	va_end(args);
> +	return result;
> +}
> +
> +void string_stream_clear(struct string_stream *this)
> +{
> +	struct string_stream_fragment *fragment, *fragment_safe;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&this->lock, flags);
> +	list_for_each_entry_safe(fragment,
> +				 fragment_safe,
> +				 &this->fragments,
> +				 node) {
> +		list_del(&fragment->node);
> +		kfree(fragment->fragment);
> +		kfree(fragment);

This is what git me down the road of checking the structure
name to begin with. :)

> +	}
> +	this->length = 0;
> +	spin_unlock_irqrestore(&this->lock, flags);
> +}
> +
> +char *string_stream_get_string(struct string_stream *this)
> +{
> +	struct string_stream_fragment *fragment;
> +	size_t buf_len = this->length + 1; /* +1 for null byte. */
> +	char *buf;
> +	unsigned long flags;
> +
> +	buf = kzalloc(buf_len, GFP_KERNEL);
> +	if (!buf)
> +		return NULL;
> +
> +	spin_lock_irqsave(&this->lock, flags);
> +	list_for_each_entry(fragment, &this->fragments, node)
> +		strlcat(buf, fragment->fragment, buf_len);
> +	spin_unlock_irqrestore(&this->lock, flags);
> +
> +	return buf;
> +}
> +
> +bool string_stream_is_empty(struct string_stream *this)
> +{
> +	bool is_empty;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&this->lock, flags);
> +	is_empty = list_empty(&this->fragments);
> +	spin_unlock_irqrestore(&this->lock, flags);
> +
> +	return is_empty;
> +}
> +
> +void destroy_string_stream(struct string_stream *stream)
> +{
> +	string_stream_clear(stream);
> +	kfree(stream);
> +}
> +
> +static void string_stream_destroy(struct kref *kref)
> +{
> +	struct string_stream *stream = container_of(kref,
> +						    struct string_stream,
> +						    refcount);
> +	destroy_string_stream(stream);
> +}
> +
> +struct string_stream *new_string_stream(void)
> +{
> +	struct string_stream *stream = kzalloc(sizeof(*stream), GFP_KERNEL);
> +
> +	if (!stream)
> +		return NULL;
> +
> +	INIT_LIST_HEAD(&stream->fragments);
> +	spin_lock_init(&stream->lock);
> +	kref_init(&stream->refcount);
> +	return stream;
> +}
> +
> +void string_stream_get(struct string_stream *stream)
> +{
> +	kref_get(&stream->refcount);
> +}
> +
> +int string_stream_put(struct string_stream *stream)
> +{
> +	return kref_put(&stream->refcount, &string_stream_destroy);
> +}
> +
> 

thanks,
-- Shuah
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
