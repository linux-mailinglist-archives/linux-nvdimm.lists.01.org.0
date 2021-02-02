Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D855030CFF6
	for <lists+linux-nvdimm@lfdr.de>; Wed,  3 Feb 2021 00:51:10 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 3233B100EAB4B;
	Tue,  2 Feb 2021 15:51:09 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.55.52.93; helo=mga11.intel.com; envelope-from=ben.widawsky@intel.com; receiver=<UNKNOWN> 
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 10385100EB847
	for <linux-nvdimm@lists.01.org>; Tue,  2 Feb 2021 15:51:05 -0800 (PST)
IronPort-SDR: Z5UKOjrtnRNk9bGZmXAR3oL9krrem5jg+/P6R2Kun3LUihZKfpFdNHbn04Wns7et+tV09SiuZW
 oHwr2F5TssHA==
X-IronPort-AV: E=McAfee;i="6000,8403,9883"; a="177446748"
X-IronPort-AV: E=Sophos;i="5.79,396,1602572400";
   d="scan'208";a="177446748"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2021 15:51:05 -0800
IronPort-SDR: 5W1kgB6IllyAnatEQfttN6uHVXqp9LN5NRvv0b6Wj/swTMx27pM5IITM30KsGTuRFw2UP+OliM
 B0mw31+NRx8Q==
X-IronPort-AV: E=Sophos;i="5.79,396,1602572400";
   d="scan'208";a="480099030"
Received: from aisallax-mobl2.amr.corp.intel.com (HELO intel.com) ([10.252.131.184])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2021 15:51:04 -0800
Date: Tue, 2 Feb 2021 15:51:03 -0800
From: Ben Widawsky <ben.widawsky@intel.com>
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: Re: [PATCH 13/14] cxl/mem: Add limited Get Log command (0401h)
Message-ID: <20210202235103.v36v3znh5tsi4g5x@intel.com>
References: <20210130002438.1872527-1-ben.widawsky@intel.com>
 <20210130002438.1872527-14-ben.widawsky@intel.com>
 <20210201182848.GL197521@fedora>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210201182848.GL197521@fedora>
Message-ID-Hash: 6ETC3XMXNDTBLLM624NSQ6GPLJZP677S
X-Message-ID-Hash: 6ETC3XMXNDTBLLM624NSQ6GPLJZP677S
X-MailFrom: ben.widawsky@intel.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-cxl@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org, linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>, Chris Browy <cbrowy@avery-design.com>, Christoph Hellwig <hch@infradead.org>, Jon Masters <jcm@jonmasters.org>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, Rafael Wysocki <rafael.j.wysocki@intel.com>, Randy Dunlap <rdunlap@infradead.org>, daniel.lll@alibaba-inc.com, "John Groves (jgroves)" <jgroves@micron.com>, "Kelley, Sean V" <sean.v.kelley@intel.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/6ETC3XMXNDTBLLM624NSQ6GPLJZP677S/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 21-02-01 13:28:48, Konrad Rzeszutek Wilk wrote:
> On Fri, Jan 29, 2021 at 04:24:37PM -0800, Ben Widawsky wrote:
> > The Get Log command returns the actual log entries that are advertised
> > via the Get Supported Logs command (0400h). CXL device logs are selected
> > by UUID which is part of the CXL spec. Because the driver tries to
> > sanitize what is sent to hardware, there becomes a need to restrict the
> > types of logs which can be accessed by userspace. For example, the
> > vendor specific log might only be consumable by proprietary, or offline
> > applications, and therefore a good candidate for userspace.
> > 
> > The current driver infrastructure does allow basic validation for all
> > commands, but doesn't inspect any of the payload data. Along with Get
> > Log support comes new infrastructure to add a hook for payload
> > validation. This infrastructure is used to filter out the CEL UUID,
> > which the userspace driver doesn't have business knowing, and taints on
> > invalid UUIDs being sent to hardware.
> 
> Perhaps a better option is to reject invalid UUIDs?
> 
> And if you really really want to use invalid UUIDs then:
> 
> 1) Make that code wrapped in CONFIG_CXL_DEBUG_THIS_IS_GOING_TO..?
> 
> 2) Wrap it with lockdown code so that you can't do this at all
>    when in LOCKDOWN_INTEGRITY or such?
> 

The commit message needs update btw as CEL is allowed in the latest rev of the
patches.

We could potentially combine this with the now added (in a branch) CONFIG_RAW
config option. Indeed I think that makes sense. Dan, thoughts?

> > 
> > Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> > ---
> >  drivers/cxl/mem.c            | 42 +++++++++++++++++++++++++++++++++++-
> >  include/uapi/linux/cxl_mem.h |  1 +
> >  2 files changed, 42 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
> > index b8ca6dff37b5..086268f1dd6c 100644
> > --- a/drivers/cxl/mem.c
> > +++ b/drivers/cxl/mem.c
> > @@ -119,6 +119,8 @@ static const uuid_t log_uuid[] = {
> >  				 0x07, 0x19, 0x40, 0x3d, 0x86)
> >  };
> >  
> > +static int validate_log_uuid(void __user *payload, size_t size);
> > +
> >  /**
> >   * struct cxl_mem_command - Driver representation of a memory device command
> >   * @info: Command information as it exists for the UAPI
> > @@ -132,6 +134,10 @@ static const uuid_t log_uuid[] = {
> >   *  * %CXL_CMD_INTERNAL_FLAG_PSEUDO: This is a pseudo command which doesn't have
> >   *    a direct mapping to hardware. They are implicitly always enabled.
> >   *
> > + * @validate_payload: A function called after the command is validated but
> > + * before it's sent to the hardware. The primary purpose is to validate, or
> > + * fixup the actual payload.
> > + *
> >   * The cxl_mem_command is the driver's internal representation of commands that
> >   * are supported by the driver. Some of these commands may not be supported by
> >   * the hardware. The driver will use @info to validate the fields passed in by
> > @@ -147,9 +153,11 @@ struct cxl_mem_command {
> >  #define CXL_CMD_INTERNAL_FLAG_HIDDEN BIT(0)
> >  #define CXL_CMD_INTERNAL_FLAG_MANDATORY BIT(1)
> >  #define CXL_CMD_INTERNAL_FLAG_PSEUDO BIT(2)
> > +
> > +	int (*validate_payload)(void __user *payload, size_t size);
> >  };
> >  
> > -#define CXL_CMD(_id, _flags, sin, sout, f)                                     \
> > +#define CXL_CMD_VALIDATE(_id, _flags, sin, sout, f, v)                         \
> >  	[CXL_MEM_COMMAND_ID_##_id] = {                                         \
> >  	.info =	{                                                              \
> >  			.id = CXL_MEM_COMMAND_ID_##_id,                        \
> > @@ -159,8 +167,12 @@ struct cxl_mem_command {
> >  		},                                                             \
> >  	.flags = CXL_CMD_INTERNAL_FLAG_##f,                                    \
> >  	.opcode = CXL_MBOX_OP_##_id,                                           \
> > +	.validate_payload = v,                                                 \
> >  	}
> >  
> > +#define CXL_CMD(_id, _flags, sin, sout, f)                                     \
> > +	CXL_CMD_VALIDATE(_id, _flags, sin, sout, f, NULL)
> > +
> >  /*
> >   * This table defines the supported mailbox commands for the driver. This table
> >   * is made up of a UAPI structure. Non-negative values as parameters in the
> > @@ -176,6 +188,8 @@ static struct cxl_mem_command mem_commands[] = {
> >  	CXL_CMD(GET_PARTITION_INFO, NONE, 0, 0x20, NONE),
> >  	CXL_CMD(GET_LSA, NONE, 0x8, ~0, MANDATORY),
> >  	CXL_CMD(GET_HEALTH_INFO, NONE, 0, 0x12, MANDATORY),
> > +	CXL_CMD_VALIDATE(GET_LOG, MUTEX, 0x18, ~0, MANDATORY,
> > +			 validate_log_uuid),
> >  };
> >  
> >  /*
> > @@ -563,6 +577,13 @@ static int handle_mailbox_cmd_from_user(struct cxl_memdev *cxlmd,
> >  			kvzalloc(cxlm->mbox.payload_size, GFP_KERNEL);
> >  
> >  	if (cmd->info.size_in) {
> > +		if (cmd->validate_payload) {
> > +			rc = cmd->validate_payload(u64_to_user_ptr(in_payload),
> > +						   cmd->info.size_in);
> > +			if (rc)
> > +				goto out;
> > +		}
> > +
> >  		mbox_cmd.payload_in = kvzalloc(cmd->info.size_in, GFP_KERNEL);
> >  		if (!mbox_cmd.payload_in) {
> >  			rc = -ENOMEM;
> > @@ -1205,6 +1226,25 @@ struct cxl_mbox_get_log {
> >  	__le32 length;
> >  } __packed;
> >  
> > +static int validate_log_uuid(void __user *input, size_t size)
> > +{
> > +	struct cxl_mbox_get_log __user *get_log = input;
> > +	uuid_t payload_uuid;
> > +
> > +	if (copy_from_user(&payload_uuid, &get_log->uuid, sizeof(uuid_t)))
> > +		return -EFAULT;
> > +
> > +	/* All unspec'd logs shall taint */
> > +	if (uuid_equal(&payload_uuid, &log_uuid[CEL_UUID]))
> > +		return 0;
> > +	if (uuid_equal(&payload_uuid, &log_uuid[DEBUG_UUID]))
> > +		return 0;
> > +
> > +	add_taint(TAINT_RAW_PASSTHROUGH, LOCKDEP_STILL_OK);
> > +
> > +	return 0;
> > +}
> > +
> >  static int cxl_xfer_log(struct cxl_mem *cxlm, uuid_t *uuid, u32 size, u8 *out)
> >  {
> >  	u32 remaining = size;
> > diff --git a/include/uapi/linux/cxl_mem.h b/include/uapi/linux/cxl_mem.h
> > index 766c231d6150..7cdc7f7ce7ec 100644
> > --- a/include/uapi/linux/cxl_mem.h
> > +++ b/include/uapi/linux/cxl_mem.h
> > @@ -39,6 +39,7 @@ extern "C" {
> >  	___C(GET_PARTITION_INFO, "Get Partition Information"),            \
> >  	___C(GET_LSA, "Get Label Storage Area"),                          \
> >  	___C(GET_HEALTH_INFO, "Get Health Info"),                         \
> > +	___C(GET_LOG, "Get Log"),                                         \
> >  	___C(MAX, "Last command")
> >  
> >  #define ___C(a, b) CXL_MEM_COMMAND_ID_##a
> > -- 
> > 2.30.0
> > 
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
